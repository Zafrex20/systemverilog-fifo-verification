class monitor;
    FifoTransaction tr;
    virtual fifo_if vif;
    mailbox #(FifoTransaction) mbx_mon_sb;

    function new(
        virtual fifo_if vif,
        mailbox #(FifoTransaction) mbx_mon_sb
    );
    this.vif = vif;
    this.mbx_mon_sb = mbx_mon_sb;
    endfunction

    task monitor_data();
        @(negedge vif.clk);
        for (int i = 0; i < NUM_TRANSACTIONS; i++) begin
            @(posedge vif.clk);
            #1;

            tr = new();

            tr.data_in = vif.data_in;
            tr.rst     = vif.rst;
            tr.wr      = vif.wr;
            tr.rd      = vif.rd;

            tr.data_out = vif.data_out;
            tr.fifo_cnt = vif.fifo_cnt;
            tr.full     = vif.full;
            tr.empty    = vif.empty;

            mbx_mon_sb.put(tr);
        end
    endtask
endclass
