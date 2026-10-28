class generator;
    FifoTransaction tr;

    mailbox #(FifoTransaction) mbx_gen_drv;
    mailbox #(FifoTransaction) mbx_gen_sb;

    function new(
        mailbox #(FifoTransaction) mbx_gen_drv,
        mailbox #(FifoTransaction) mbx_gen_sb
    );
        this.mbx_gen_drv = mbx_gen_drv;
        this.mbx_gen_sb  = mbx_gen_sb;
    endfunction

    //// Make FIFO reset
    task reset_fifo();
        tr = new();
        if (!tr.randomize() with {
            rst == 1;
            wr  == 0;
            rd  == 0;
        }) begin
            $error("Reset randomization failed");
            return;
        end

        mbx_gen_drv.put(tr.copy());
        mbx_gen_sb.put(tr.copy());
    endtask

    //// Make FIFO full
    task fill_fifo();
        for (int i = 0; i < 8; i++) begin
            tr = new();
            if (!tr.randomize() with {
                rst == 0;
                wr  == 1;
                rd  == 0;
            }) begin
                $error("Write randomization failed");
                return;
            end

            mbx_gen_drv.put(tr.copy());
            mbx_gen_sb.put(tr.copy());
        end
    endtask

    //// WRITE when FIFO is FULL
    task test_full();
        tr = new();
        if (!tr.randomize() with {
                rst == 0;
                wr  == 1;
                rd  == 0;
            }) begin
                $error("Write randomization failed");
                return;
            end

            mbx_gen_drv.put(tr.copy());
            mbx_gen_sb.put(tr.copy());
    endtask

    //// WRITE and READ when is FULL
    task wr_rd_full();
        tr = new();
        if (!tr.randomize() with {
            rst == 0;
            wr  == 1;
            rd  == 1;
        }) begin
            $error("Write and Read randomization failed");
            return;
        end

        mbx_gen_drv.put(tr.copy());
        mbx_gen_sb.put(tr.copy());
    endtask

    //// Make FIFO empty
    task empty_fifo();
        for (int i = 0; i < 8; i++) begin
            tr = new();
            if(!tr.randomize() with {
                rst == 0;
                wr  == 0;
                rd  == 1;
            }) begin
                $error("Read randomization failed");
                return;
            end

            mbx_gen_drv.put(tr.copy());
            mbx_gen_sb.put(tr.copy());
        end
    endtask

    //// READ when FIFO is EMPTY
    task test_empty();
        tr = new();
        if(!tr.randomize() with {
            rst == 0;
            wr  == 0;
            rd  == 1;
        }) begin
            $error("Read randomization failed");
            return;
        end

        mbx_gen_drv.put(tr.copy());
        mbx_gen_sb.put(tr.copy());
    endtask

    task wr_rd_empty();
        tr = new();
        if (!tr.randomize() with {
            rst == 0;
            wr  == 1;
            rd  == 1;
        }) begin
            $error("Read randomization failed");
            return;
        end

        mbx_gen_drv.put(tr.copy());
        mbx_gen_sb.put(tr.copy());
    endtask

    task gen();
        reset_fifo();
        fill_fifo();
        test_full();
        wr_rd_full();
        empty_fifo();
        test_empty();
        wr_rd_empty();
    endtask
endclass
