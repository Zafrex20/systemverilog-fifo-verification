module tb;
    import fifo_tb_pkg::*;

    fifo_if fif();

    scoreboard sb;
    generator grt;
    monitor mon;
    driver drv;

    mailbox #(FifoTransaction) mbx_gen_drv;
    mailbox #(FifoTransaction) mbx_gen_sb;
    mailbox #(FifoTransaction) mbx_mon_sb;

    FIFO dut(
        .clk      (fif.clk),
        .rst      (fif.rst),
        .wr       (fif.wr),
        .rd       (fif.rd),
        .data_in  (fif.data_in),
        .data_out (fif.data_out),
        .fifo_cnt (fif.fifo_cnt),
        .full     (fif.full),
        .empty    (fif.empty)
    );

    initial begin
        fif.clk = 0;
        forever #5 fif.clk = ~fif.clk;
    end

    initial begin
        mbx_gen_drv = new();
        mbx_gen_sb  = new();
        mbx_mon_sb  = new();

        grt = new(mbx_gen_drv, mbx_gen_sb);
        drv = new(fif, mbx_gen_drv);
        mon = new(fif, mbx_mon_sb);
        sb  = new(mbx_gen_sb, mbx_mon_sb);

        fork
            grt.gen();
            drv.drive();
            mon.monitor_data();
            sb.scoreboard_data();
        join

        $finish;
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb);
    end
endmodule
