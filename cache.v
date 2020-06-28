module cache(clk, instruction, address, processorData);
    input clk;
    input instruction;
    input[31:0]address;
    input[511:0]processorData;
    reg[3:0]offset;
    reg[19:0]tag;
    reg[7:0]index; 
    reg[511:0]data;   
    reg dirtyBit;
    reg validBit;
    reg[19:0] tagArray[255:0];
    reg[511:0] dataArray[255:0];
    reg[255:0] validBitArray = 0;
    reg[15:0] dirtyBitArray[255:0];
    reg[31:0] addressArray[15:0][255:0];
    integer i = 0;
    integer j = 0;
    integer k = 0;
    integer hits = 0;
    integer misses = 0;
    integer startBit, endBit;
    integer data_file ; // file handler
    integer scan_file; // file handler
    logic  signed [31:0] captured_data;

    task initializeDirty;
        begin
        for(i = 0; i < 256; i = i + 1)
            begin
                dirtyBitArray[i] = 0;
            end
        end
    endtask

    initial begin
        initializeDirty();
    end

    always@(posedge clk)
    begin
        offset = address[3:0];
        tag = address[31:12];
        index = address[11:4]; 
        // $display("offset: %b, tag: %b, index: %b, address : %d\n", offset, tag, index, address);
        if(instruction == 0)
            begin
            readData(index,data);
            end
        else
            begin
            writeData(index,processorData);
            end
        // $display("Hits: %d, Misses: %d\n", hits, misses);
        $display("%d %d\n", hits, misses);
    end

    function isValid;
        input [7:0]index;
        isValid = validBitArray[index];
    endfunction

    function isDirty;
        input [7:0]index;
        input [3:0]offset;
        isDirty = dirtyBitArray[index][offset];
    endfunction

    function compareTag;
        input [7:0]index;
        compareTag = (tag == tagArray[index]);
    endfunction

    task readData;
        /*
        Reads data from cache
        */
        input [7:0]index;
        output [511:0] data;
        begin
            if(compareTag(index))
                begin
                    if(isValid(index))
                        begin
                            hits = hits + 1;
                            data = dataArray[index];
                        end
                end
            else
                begin
                    misses = misses + 1;
                    for(k = 0; k < 16; k = k + 1)
                        begin
                            if(isDirty(index,k))
                                begin
                                    memWrite(dataArray[index],k,addressArray[index][k]);
                                end
                        end
                    memRead(address); // Changes the data ONLY
                    dataArray[index] = data;
                    validBitArray[index] = 1;
                    tagArray[index] = tag;
                end
        end
    endtask

    task writeData;
        /*
        Writes data from processor to cache (NOT FROM MEMORY)
        */
        input [7:0]index;
        input [511:0]processorData;
        begin
            for(k = 0; k < 16; k = k + 1)
                begin
                    if(isDirty(index,k))
                        begin
                            memWrite(dataArray[index],k,addressArray[index][k]);
                        end
                end
            // The below data can be assumed as some data given by processor
            // data = 512'b10100010101111110100000101101111110110000101111000000100111110100011001001001001011100011110001000111111010110110011101001100101011010101000011011111110000010011011111111010010010110101000110110111000000010011110101011000000011101000011101101000101101111010101110010001110000011110101000100101011100010011001000111110001000111001110000111010001010111111010000010110111111011000010111100000010011111010001100100100100101110001111000100011111101011011001110100110010101101010100001101111111000001001101111111101001;                  
            dataArray[index] = processorData;
            validBitArray[index] = 1;
            for(i = 0; i < 16; i = i + 1)
                begin
                    dirtyBitArray[index][i] = 1;
                    addressArray[index][i] = address+i;
                end
        end      
    endtask

    task memWrite;
        /*
        Writing into memory from cache WORD wise
        */
        input [511:0]data;  
        input [3:0]offset;
        input [31:0] address;  
        begin
            data_file = $fopen("mainMemory.txt","r+");
            if (data_file == 0) 
                begin
                    $display("data_file handle was NULL");
                    $finish;
                end

            for(i = 0; (i <= address) && !$feof(data_file); i = i + 1)
                begin
                    if (!$feof(data_file)) 
                        begin
                            if(i == address)
                                begin
                                    case(offset)
                                        4'b0000: $fwrite(data_file,"%b\n", dataArray[index][31:0]);
                                        4'b0001: $fwrite(data_file,"%b\n", dataArray[index][63:32]);
                                        4'b0010: $fwrite(data_file,"%b\n", dataArray[index][95:64]);
                                        4'b0011: $fwrite(data_file,"%b\n", dataArray[index][127:96]);
                                        4'b0100: $fwrite(data_file,"%b\n", dataArray[index][159:128]);
                                        4'b0101: $fwrite(data_file,"%b\n", dataArray[index][191:160]); 
                                        4'b0110: $fwrite(data_file,"%b\n", dataArray[index][223:192]); 
                                        4'b0111: $fwrite(data_file,"%b\n", dataArray[index][255:224]); 
                                        4'b1000: $fwrite(data_file,"%b\n", dataArray[index][287:256]); 
                                        4'b1001: $fwrite(data_file,"%b\n", dataArray[index][319:288]); 
                                        4'b1010: $fwrite(data_file,"%b\n", dataArray[index][351:320]); 
                                        4'b1011: $fwrite(data_file,"%b\n", dataArray[index][383:352]);  
                                        4'b1100: $fwrite(data_file,"%b\n", dataArray[index][415:384]);  
                                        4'b1101: $fwrite(data_file,"%b\n", dataArray[index][447:416]);  
                                        4'b1110: $fwrite(data_file,"%b\n", dataArray[index][479:448]); 
                                        4'b1111: $fwrite(data_file,"%b\n", dataArray[index][511:480]);
                                    endcase 
                                    dirtyBitArray[index][offset] = 0;
                                end
                            else if (i < address) scan_file = $fscanf(data_file, "%b\n", captured_data);
                        end
                end
        end

    endtask

    task memRead;
        /*
        Reading from memory to cache BLOCK wise
        */
        input [31:0]address;
        begin
            data_file = $fopen("mainMemory.txt", "r");
            if (data_file == 0) 
                begin
                    $display("data_file handle was NULL");
                    $finish;
                end

            for(i = 0; (i <= address) && !$feof(data_file); i = i + 1)
            begin
                if (!$feof(data_file)) 
                    begin
                        scan_file = $fscanf(data_file, "%b\n", captured_data);
                        if(i == address)
                            begin
                                data[31:0] = captured_data; 
                                scan_file = $fscanf(data_file, "%b\n", captured_data);
                                data[63:32] = captured_data; 
                                scan_file = $fscanf(data_file, "%b\n", captured_data);
                                data[95:64] = captured_data; 
                                scan_file = $fscanf(data_file, "%b\n", captured_data);
                                data[127:96] = captured_data; 
                                scan_file = $fscanf(data_file, "%b\n", captured_data);
                                data[159:128] = captured_data;
                                scan_file = $fscanf(data_file, "%b\n", captured_data);
                                data[191:160] = captured_data;
                                scan_file = $fscanf(data_file, "%b\n", captured_data); 
                                data[223:192] = captured_data;
                                scan_file = $fscanf(data_file, "%b\n", captured_data); 
                                data[255:224] = captured_data;
                                scan_file = $fscanf(data_file, "%b\n", captured_data); 
                                data[287:256] = captured_data;
                                scan_file = $fscanf(data_file, "%b\n", captured_data); 
                                data[319:288] = captured_data;
                                scan_file = $fscanf(data_file, "%b\n", captured_data); 
                                data[351:320] = captured_data;
                                scan_file = $fscanf(data_file, "%b\n", captured_data);  
                                data[383:352] = captured_data;
                                scan_file = $fscanf(data_file, "%b\n", captured_data);  
                                data[415:384] = captured_data;
                                scan_file = $fscanf(data_file, "%b\n", captured_data);  
                                data[447:416] = captured_data;
                                scan_file = $fscanf(data_file, "%b\n", captured_data);  
                                data[479:448] = captured_data;
                                scan_file = $fscanf(data_file, "%b\n", captured_data);  
                                data[511:480] = captured_data; 
                            end
                    end
            end
        end
      
    endtask

endmodule