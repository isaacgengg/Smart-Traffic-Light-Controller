module tlc_controller_verl(
    output wire [1:0] highwaySignal, farmSignal,                            //Output nets
    output wire [3:0] JB,                                                   /////////////
    input wire Clk,                                                         //Input nets
    input wire Rst,
    input wire farmSensor                                                         //
                                                   //
);
    wire RstSync;                                                           //Intermediate nets
    wire RstCount;                                                          //
    wire farmSensorSync;                                                    //
    reg [30:0] Count = 0;                                                   //
    
    assign JB[3] = RstCount;                                                //Output for debugging
    
    synchronizer syncRst(RstSync, Rst, Clk);                                //Synchronizing the analog inputs
    synchronizer syncfarmSensor(farmSensorSync, farmSensor, Clk);            //
    
    tlc_fsm FSM(                                                            //Initializing the FSM
        .state(JB[2:0]), 
        .RstCount(RstCount), 
        .highwaySignal(highwaySignal), 
        .farmSignal(farmSignal), 
        .Count(Count), 
        .Clk(Clk), 
        .Rst(Rst),
        .farmSensor(farmSensorSync)
        );
        
    always@(posedge Clk)begin                                               //Basic up-counter
        if(RstCount)                                                        
            Count <= 0;                                                      //Resets Count to 0 if RstCount is HIGH
        else
            Count <= Count + 1;                                              //Increments Count at the beginning of each clock cycle
    end
endmodule


