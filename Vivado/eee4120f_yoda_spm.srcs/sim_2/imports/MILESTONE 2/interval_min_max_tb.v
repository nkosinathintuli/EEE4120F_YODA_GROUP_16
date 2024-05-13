`timescale 1ns / 1ps

module audio_min_max_tb;
localparam N = 100; // Number of samples
localparam NUM_INTERVALS = N/10;

reg reset, start, clk;
reg signed [31:0] raw_audio [N-1:0];
wire done;
wire signed [31:0] out_max [NUM_INTERVALS-1:0], out_min [NUM_INTERVALS-1:0];
reg [15:0] interval_len;
// Instantiate audio_min_max_interval
audio_min_max_interval aud_minmaxint (
    .reset(reset),
    .start(start),
    .clk(clk),
    .raw_audio(raw_audio),
    .done(done),
    .interval_len(interval_len),
    .out_max(out_max),
    .out_min(out_min)
);
// Clock generation
always #5 clk = ~clk;
integer i = 0;
// Test case: Hardcoded array from CSV file
initial begin
    clk = 0;
    reset = 1;
    start = 0;
    interval_len = 10;
    // Load the hardcoded array
    raw_audio[0] = 196608;
    raw_audio[1] = 458752;
    raw_audio[2] = 0;
    raw_audio[3] = 327680;
    raw_audio[4] = 458752;
    raw_audio[5] = 262144;
    raw_audio[6] = 196608;
    raw_audio[7] = 458752;
    raw_audio[8] = 327680;
    raw_audio[9] = 327680;
    raw_audio[10] = 131072;
    raw_audio[11] = 196608;
    raw_audio[12] = -65536;
    raw_audio[13] = 0;
    raw_audio[14] = 262144;
    raw_audio[15] = 131072;
    raw_audio[16] = -131072;
    raw_audio[17] = -65536;
    raw_audio[18] = 65536;
    raw_audio[19] = 65536;
    raw_audio[20] = 65536;
    raw_audio[21] = -131072;
    raw_audio[22] = -131072;
    raw_audio[23] = 65536;
    raw_audio[24] = 131072;
    raw_audio[25] = -262144;
    raw_audio[26] = -262144;
    raw_audio[27] = 0;
    raw_audio[28] = -131072;
    raw_audio[29] = -196608;
    raw_audio[30] = -131072;
    raw_audio[31] = -65536;
    raw_audio[32] = -196608;
    raw_audio[33] = -393216;
    raw_audio[34] = -458752;
    raw_audio[35] = -327680;
    raw_audio[36] = -196608;
    raw_audio[37] = -196608;
    raw_audio[38] = -327680;
    raw_audio[39] = -262144;
    raw_audio[40] = -524288;
    raw_audio[41] = -327680;
    raw_audio[42] = -589824;
    raw_audio[43] = -524288;
    raw_audio[44] = -524288;
    raw_audio[45] = -393216;
    raw_audio[46] = -589824;
    raw_audio[47] = -720896;
    raw_audio[48] = -851968;
    raw_audio[49] = -720896;
    raw_audio[50] = -786432;
    raw_audio[51] = -720896;
    raw_audio[52] = -786432;
    raw_audio[53] = -786432;
    raw_audio[54] = -655360;
    raw_audio[55] = -720896;
    raw_audio[56] = -851968;
    raw_audio[57] = -917504;
    raw_audio[58] = -589824;
    raw_audio[59] = -851968;
    raw_audio[60] = -589824;
    raw_audio[61] = -589824;
    raw_audio[62] = -786432;
    raw_audio[63] = -1048576;
    raw_audio[64] = -917504;
    raw_audio[65] = -1245184;
    raw_audio[66] = -983040;
    raw_audio[67] = -1048576;
    raw_audio[68] = -851968;
    raw_audio[69] = -1048576;
    raw_audio[70] = -983040;
    raw_audio[71] = -1048576;
    raw_audio[72] = -1048576;
    raw_audio[73] = -917504;
    raw_audio[74] = -917504;
    raw_audio[75] = -1114112;
    raw_audio[76] = -1179648;
    raw_audio[77] = -917504;
    raw_audio[78] = -983040;
    raw_audio[79] = -1376256;
    raw_audio[80] = -1245184;
    raw_audio[81] = -983040;
    raw_audio[82] = -1245184;
    raw_audio[83] = -1179648;
    raw_audio[84] = -1310720;
    raw_audio[85] = -1114112;
    raw_audio[86] = -1245184;
    raw_audio[87] = -1245184;
    raw_audio[88] = -1441792;
    raw_audio[89] = -1245184;
    raw_audio[90] = -1245184;
    raw_audio[91] = -1376256;
    raw_audio[92] = -1441792;
    raw_audio[93] = -1507328;
    raw_audio[94] = -1310720;
    raw_audio[95] = -1507328;
    raw_audio[96] = -1441792;
    raw_audio[97] = -1769472;
    raw_audio[98] = -1376256;
    raw_audio[99] = -1441792;
    #10 reset = 0;
    #10 start = 1;
    #10 start = 0;
    // Wait for the computation to complete
    wait (done);
    // Print the results
    #5
    for (i= 0; i<NUM_INTERVALS; i=i+1) begin
        $display("%1d. Maximum: %1d, Minimum: %1d", i, out_max[i], out_min[i]);
    end
    $finish;
    
end
initial begin
    $dumpfile("dump.vcd");
    $dumpvars; 
end
endmodule