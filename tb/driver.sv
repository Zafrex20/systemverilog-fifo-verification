class driver;
    FifoTransaction tr;
    virtual fifo_if vif;
    mailbox #(FifoTransaction) mbx_gen_drv;

    function new(
        virtual fifo_if vif,
        mailbox #(FifoTransaction) mbx_gen_drv
    );

    this.mbx_gen_drv = mbx_gen_drv;
    this.vif = vif;
    endfunction

    task drive();
        for (int i = 0; i < NUM_TRANSACTIONS; i++) begin
            mbx_gen_drv.get(tr);

            @(negedge vif.clk);

            vif.data_in = tr.data_in;
            vif.rst     = tr.rst;
            vif.wr      = tr.wr;
            vif.rd      = tr.rd;
        end
    endtask
endclass
