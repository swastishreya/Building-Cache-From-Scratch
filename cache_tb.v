module cache_tb;
    reg clk;
    reg instruction;
    reg [31:0]address ;
    reg [511:0]processorData;
    // wire out;
    cache uut (
        .clk(clk),
        .instruction(instruction),
        .address(address),
        .processorData(processorData)
    );
    initial begin
        processorData = 3289;
        clk = 0;
        instruction = 1;
        address = 0; #10; 
        instruction = 0;
        address = 0; #10;
        instruction = 0;
        address = 32'b110110000000110100; #10;
        instruction = 1;
        address = 32'b000110011110110100; #10;
        instruction = 0;
        address = 32'b100011111010110100; #10;
        instruction = 0;
        address = 32'b000111101110110100; #10;
        instruction = 1;
        address = 32'b001111101110110110; #10;
        instruction = 0;
        address = 32'b000001111010110100; #10;
        instruction = 1;
        address = 32'b001111101010110100; #10;
        instruction = 0;
        address = 32'b000111100101110110; #10;
        instruction = 1;
        address = 32'b111011010110110100; #10;
        instruction = 0;
        address = 32'b110011101110110110; #10;
        instruction = 1;
        address = 32'b111000101110101110; #10;
        instruction = 0;
        address = 32'b010011111010110100; #10;
        instruction = 0;
        address = 32'b110000101110110100; #10;
        instruction = 1;
        address = 32'b001111101010110110; #10;
        instruction = 0;
        address = 32'b000001111010110100; #10;
        instruction = 0;
        address = 32'b100011101010110100; #10;
        instruction = 0;
        address = 32'b000101100101110110; #10;
        instruction = 1;
        address = 32'b110110000000000000; #10;
        instruction = 0;
        address = 32'b000110011110110100; #10;
        instruction = 1;
        address = 32'b100011111010110100; #10;
        instruction = 1;
        address = 32'b000111101110110100; #10;
        instruction = 0;
        address = 32'b001111101110110110; #10;
        instruction = 1;
        address = 32'b000001111010110100; #10;
        instruction = 0;
        address = 32'b001111101010110100; #10;
        instruction = 1;
        address = 32'b000111100101110110; #10;
        instruction = 0;
        address = 32'b111011010110110100; #10;
        instruction = 0;
        address = 32'b000111101110110100; #10;
        instruction = 1;
        address = 32'b001100101110110110; #10;
        instruction = 0;
        address = 32'b100001111010110100; #10;
        instruction = 1;
        address = 32'b100011101010110100; #10;
        instruction = 0;
        address = 32'b000111100101110110; #10;
        instruction = 1;
        address = 32'b111110010110110100; #10;
        instruction = 0;
        address = 32'b110011101110110110; #10;
        instruction = 1;
        address = 32'b111000101110101110; #10;
        instruction = 1;
        address = 32'b010011111010110100; #10;
        instruction = 1;
        address = 32'b110000111000110100; #10;
        instruction = 0;
        address = 32'b001100101010110110; #10;
        instruction = 0;
        address = 32'b000111100101110110; #10;
        instruction = 0;
        address = 32'b111011010110110100; #10;
        instruction = 0;
        address = 32'b000111101110110100; #10;
        instruction = 1;
        address = 32'b001100101110110110; #10;
        instruction = 0;
        address = 32'b100001111010110100; #10;
        instruction = 1;
        address = 32'b100011101010110100; #10;
        instruction = 0;
        address = 32'b000111100101110110; #10;
        instruction = 0;
        address = 32'b111110010110110100; #10;
        instruction = 1;
        address = 32'b110011101110110110; #10;
        instruction = 0;
        address = 32'b100011101010110100; #10;
        instruction = 0;
        address = 32'b000101100101110110; #10;
        instruction = 1;
        address = 32'b110110000000000000; #10;
        instruction = 0;
        address = 32'b000110011110110100; #10;
        instruction = 1;
        address = 32'b100011111010110100; #10;
        instruction = 1;
        address = 32'b000111101110110100; #10;
        instruction = 0;
        address = 32'b001111101110110110; #10;
        instruction = 1;
        address = 32'b000001111010110100; #10;
        instruction = 0;
        address = 32'b001111101010110100; #10;
        instruction = 1;
        address = 32'b000111100101110110; #10;
        instruction = 0;
        address = 32'b111011010110110100; #10;
        instruction = 0;
        address = 32'b000111101110110100; #10;
        instruction = 1;
        address = 32'b001100101110110110; #10;
        instruction = 0;
        address = 32'b100001111010110100; #10;
        instruction = 1;
        address = 32'b111000101110101110; #10;
        instruction = 0;
        address = 32'b010011111010110100; #10;
        instruction = 0;
        address = 32'b110000101110110100; #10;
        instruction = 1;
        address = 32'b001111101010110110; #10;
        instruction = 0;
        address = 32'b000001111010110100; #10;
        instruction = 0;
        address = 32'b100011101010110100; #10;
        instruction = 0;
        address = 32'b000101100101110110; #10;
        instruction = 1;
        address = 32'b110110000000000000; #10;
        instruction = 0;
        address = 32'b000110011110110100; #10;
        instruction = 1;
        address = 32'b100011111010110100; #10;
        instruction = 1;
        address = 32'b000111101110110100; #10;
        instruction = 0;
        address = 32'b001111101110110110; #10;
        instruction = 1;
        address = 32'b000001111010110100; #10;
        $finish;
    end

    always
    begin
        clk = 1; #5;
        clk = 0; #5;
    end
endmodule