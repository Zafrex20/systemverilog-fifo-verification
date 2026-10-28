package fifo_tb_pkg;
    localparam int NUM_TRANSACTIONS = 21;

    `include "fifo_transaction.sv"
    `include "generator.sv"
    `include "driver.sv"
    `include "monitor.sv"
    `include "scoreboard.sv"
endpackage
