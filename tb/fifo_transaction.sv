class FifoTransaction;
    rand bit [7:0] data_in;
    rand bit       rst;
    rand bit       wr;
    rand bit       rd;

    bit [7:0] data_out;
    bit [3:0] fifo_cnt;
    bit       full;
    bit       empty;

    function void display();
        $display("Data_In: %0d | Rst: %0d | Wr: %0d | Rd: %0d", data_in, rst, wr, rd);
    endfunction

    function FifoTransaction copy();
        copy = new();
        copy.data_in = data_in;
        copy.rst     = rst;
        copy.wr      = wr;
        copy.rd      = rd;
    endfunction
endclass
