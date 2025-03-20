module DualPortRAM #(
    parameter DATA_WIDTH = 8, DEPTH = 256
) (
    input clka, wr_ena, rd_ena,
    input clkb, wr_enb, rd_enb,
    input [$clog2(DEPTH)-1:0] addra, addrb,
    input [DATA_WIDTH-1:0] data_ina, data_inb,
    output reg [DATA_WIDTH-1:0] data_outa, data_outb
);
    reg [DATA_WIDTH-1:0] mem[0:DEPTH-1];
    always @(posedge clka) begin
        if(wr_ena) //prioritizing wr over rd if both are HIGH
            data_outa <= mem[addra];
        else if(rd_ena)
            mem[addra] <= data_ina;
    end
    always @(posedge clkb) begin
        if(wr_enb)
            data_outb <= mem[addrb];
        else if(rd_enb)
            mem[addrb] <= data_inb;
    end
endmodule
