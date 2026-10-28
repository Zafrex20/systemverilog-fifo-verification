class scoreboard;
    bit [7:0] expected_fifo[$];

    FifoTransaction tr_actual;
    FifoTransaction tr_expected;

    mailbox #(FifoTransaction) mbx_gen_sb;
    mailbox #(FifoTransaction) mbx_mon_sb;

    function new(
        mailbox #(FifoTransaction) mbx_gen_sb,
        mailbox #(FifoTransaction) mbx_mon_sb
    );
        this.mbx_gen_sb = mbx_gen_sb;
        this.mbx_mon_sb = mbx_mon_sb;
    endfunction

    task scoreboard_data();
        int size_before;

        $display("");
        $display("==================================================");
        $display("                 SCOREBOARD");
        $display("==================================================");

        for (int i = 0; i < NUM_TRANSACTIONS; i++) begin

            mbx_gen_sb.get(tr_expected);
            mbx_mon_sb.get(tr_actual);

            size_before = expected_fifo.size();

            // 1 - ACTUALIZAR REFERENCE MODEL
            $display("");
            $display("-------------------------------------");
            // RESET
            if (tr_expected.rst) begin
                expected_fifo.delete();

                $display("");
                $display("[Transaction %0d] RESET", i + 1);
                $display("FIFO SIZE      : %0d -> %0d", size_before, expected_fifo.size());
                $display("RESULT         : PASS");
            end

            // WRITE ONLY
            else if (tr_expected.wr && !tr_expected.rd) begin
                if (expected_fifo.size() < 8) begin
                    expected_fifo.push_back(tr_expected.data_in);

                    $display("");
                    $display("[Transaction %0d] WRITE", i + 1);
                    $display("Data In        : %0d", tr_expected.data_in);
                    $display("FIFO SIZE      : %0d -> %0d", size_before, expected_fifo.size());
                    $display("RESULT         : PASS");
                end
                else begin
                    $display("");
                    $display("[Transaction %0d] WRITE - FIFO FULL", i + 1);
                    $display("Data In        : %0d", tr_expected.data_in);
                    $display("WRITE          : IGNORED");
                    $display("FIFO SIZE      : %0d -> %0d", size_before, expected_fifo.size());
                    $display("RESULT         : PASS");
                end
            end

            // READ ONLY
            else if (tr_expected.rd && !tr_expected.wr) begin
                if (expected_fifo.size() > 0) begin
                    if (expected_fifo[0] == tr_actual.data_out) begin
                        $display("");
                        $display("[Transaction %0d] READ", i + 1);
                        $display("Expected       : %0d", expected_fifo[0]);
                        $display("Actual         : %0d", tr_actual.data_out);
                        $display("FIFO SIZE      : %0d -> %0d", size_before, size_before - 1);
                        $display("RESULT         : PASS");
                    end
                    else begin
                        $error("");
                        $display("[Transaction %0d] READ", i + 1);
                        $display("Expected       : %0d", expected_fifo[0]);
                        $display("Actual         : %0d", tr_actual.data_out);
                        $display("FIFO SIZE      : %0d -> %0d", size_before, size_before - 1);
                        $display("RESULT         : FAIL");
                    end
                    // El DUT realizó el READ, así que el modelo también debe
                    // eliminar el elemento aunque haya sido mismatch
                    expected_fifo.pop_front();
                end
                else begin
                    $display("");
                    $display("[Transaction %0d] READ - FIFO EMPTY", i + 1);
                    $display("READ           : IGNORED");
                    $display("FIFO SIZE      : %0d -> %0d", size_before, expected_fifo.size());
                    $display("RESULT         : PASS");
                end
            end

            // WRITE + READ
            else if (tr_expected.wr && tr_expected.rd) begin

                // NORMAL: 1 <= FIFO SIZE <= 7
                if (expected_fifo.size() > 0 && expected_fifo.size() < 8) begin
                    if (expected_fifo[0] == tr_actual.data_out) begin
                        $display("");
                        $display("[Transaction %0d] READ + WRITE - NORMAL", i + 1);
                        $display("Read Expected : %0d", expected_fifo[0]);
                        $display("Read Actual   : %0d", tr_actual.data_out);
                        $display("Write Data    : %0d", tr_expected.data_in);

                        expected_fifo.pop_front();
                        expected_fifo.push_back(tr_expected.data_in);

                        $display("FIFO SIZE     : %0d -> %0d", size_before, expected_fifo.size());
                        $display("RESULT        : PASS");
                    end
                    else begin
                        $error("");
                        $display("[Transaction %0d] READ + WRITE - NORMAL", i + 1);
                        $display("Read Expected : %0d", expected_fifo[0]);
                        $display("Read Actual   : %0d", tr_actual.data_out);
                        $display("Write Data    : %0d", tr_expected.data_in);

                        expected_fifo.pop_front();
                        expected_fifo.push_back(tr_expected.data_in);

                        $display("FIFO SIZE     : %0d -> %0d", size_before, expected_fifo.size());
                        $display("RESULT        : FAIL");
                    end
                end

                // FULL: FIFO SIZE = 8
                else if (expected_fifo.size() == 8) begin
                    if (expected_fifo[0] == tr_actual.data_out) begin
                        $display("");
                        $display("[Transaction %0d] READ + WRITE - FULL", i + 1);
                        $display("Read Expected  : %0d", expected_fifo[0]);
                        $display("Read Actual    : %0d", tr_actual.data_out);
                        $display("Write Data     : %0d", tr_expected.data_in);

                        expected_fifo.pop_front();
                        expected_fifo.push_back(tr_expected.data_in);

                        $display("FIFO SIZE      : %0d -> %0d", size_before, expected_fifo.size());
                        $display("RESULT         : PASS");

                    end
                    else begin
                        $error("");
                        $display("[Transaction %0d] READ + WRITE - FULL", i + 1);
                        $display("Read Expected  : %0d", expected_fifo[0]);
                        $display("Read Actual    : %0d", tr_actual.data_out);
                        $display("Write Data     : %0d", tr_expected.data_in);

                        expected_fifo.pop_front();
                        expected_fifo.push_back(tr_expected.data_in);

                        $display("FIFO SIZE      : %0d -> %0d", size_before, expected_fifo.size());
                        $display("RESULT         : FAIL");
                    end
                end

                // EMPTY: FIFO SIZE = 0
                else if (expected_fifo.size() == 0) begin

                    expected_fifo.push_back(tr_expected.data_in);

                    $display("");
                    $display("[Transaction %0d] READ + WRITE - EMPTY", i + 1);
                    $display("Read           : IGNORED");
                    $display("Write Data     : %0d", tr_expected.data_in);
                    $display("FIFO SIZE      : %0d -> %0d", size_before, expected_fifo.size());
                    $display("RESULT         : PASS");
                end
            end

            // NO OPERATION
            else begin
                $display("");
                $display("[Transaction %0d] NO OPERATION", i + 1);
                $display("FIFO SIZE      : %0d -> %0d", size_before, expected_fifo.size());
                $display("RESULT         : PASS");
            end

            // 2 - CHECK DEL ESTADO DEL DUT

            if (expected_fifo.size() == tr_actual.fifo_cnt) begin
                $display("");
                $display("FIFO SB COUNT  : %0d", expected_fifo.size());
                $display("FIFO DUT COUNT : %0d", tr_actual.fifo_cnt);
                $display("RESULT         : PASS");
            end else begin
                $display("");
                $display("FIFO SB COUNT  : %0d", expected_fifo.size());
                $display("FIFO DUT COUNT : %0d", tr_actual.fifo_cnt);
                $display("RESULT         : FAIL");
            end

            if (tr_actual.empty == (expected_fifo.size() ==  0)) begin
                $display("");
                $display("EMPTY FLAG     : %0d", tr_actual.empty);
                $display("RESULT         : PASS");
            end else begin
                $display("");
                $display("EMPTY FLAG     : %0d", tr_actual.empty);
                $display("RESULT         : FAIL");
            end

            if (tr_actual.full == (expected_fifo.size() == 8)) begin
                $display("");
                $display("FULL FLAG      : %0d", tr_actual.full);
                $display("RESULT         : PASS");
            end else begin
                $display("");
                $display("FULL FLAG      : %0d", tr_actual.full);
                $display("RESULT         : FAIL");
            end
        end

        $display("");
        $display("==================================================");
        $display("              END OF SCOREBOARD");
        $display("==================================================");
    endtask
endclass
