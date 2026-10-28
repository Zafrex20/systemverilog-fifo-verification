interface fifo_if;
    // INPUTS
    bit [7:0] data_in;
    bit       clk;
    bit       rst;
    bit       wr;
    bit       rd;

    // OUTPUTS
    bit [7:0] data_out;
    bit [3:0] fifo_cnt;
    bit       full;
    bit       empty;
endinterface
