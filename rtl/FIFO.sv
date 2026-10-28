module FIFO(
    input  bit [7:0] data_in,
    input  bit       clk,
    input  bit       rst,
    input  bit       wr,
    input  bit       rd,

    output bit [7:0] data_out,
    output bit [3:0] fifo_cnt,
    output bit       full,
    output bit       empty
);

    logic [7:0] fifo_ram[0:7];
    logic [2:0] wr_ptr, rd_ptr;

    assign empty = (fifo_cnt == 0);
    assign full  = (fifo_cnt == 8);

    always @(posedge clk) begin
        if (rst) begin
            fifo_cnt <= 0;
            data_out <= 0;
            wr_ptr   <= 0;
            rd_ptr   <= 0;
        end else begin
            if (wr && !full || wr && rd) begin
            fifo_ram[wr_ptr] <= data_in;
            end

            if (rd && !empty) begin
            data_out <= fifo_ram[rd_ptr];
            end

            if (wr && !full || wr && rd) wr_ptr <= wr_ptr + 1;
            if (rd && !empty)            rd_ptr <= rd_ptr + 1;

            //$display("DUT | wr=%0d rd=%0d | fifo_cnt BEFORE=%0d | empty=%0d full=%0d", wr, rd, fifo_cnt, empty, full);

            case ({rd,wr})
                2'b00:begin
                end
                2'b01:begin
                    //fifo_cnt <= (fifo_cnt == 8) ?8:fifo_cnt + 1;
                    if (!full) begin
                        fifo_cnt <= fifo_cnt + 1;
                    end
                end
                2'b10:begin
                    if (!empty) begin
                        //$display("DUT | READ | fifo_cnt %0d -> %0d", fifo_cnt, fifo_cnt - 1);
                        fifo_cnt <= fifo_cnt - 1;
                    end
                end
                2'b11:begin
                    if (empty) begin
                        fifo_cnt <= fifo_cnt + 1;
                    end
                end
            endcase
        end
    end
endmodule
