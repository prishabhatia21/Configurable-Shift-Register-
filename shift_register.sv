//00:SISO,01:SIPO,10:PISO,11:PIPO
//0:left,1:right

module shift_register #(parameter width=8)(input logic clk,reset,
sync_clr,load,ce,input logic [1:0] mode, input logic shift_dir, 
serial_in, input logic [width-1:0] data_in, output logic serial_out, 
output logic [width-1:0] data_out);
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
        data_out<='0;
        serial_out<='0;
    end
    else if (!ce)
      begin 
        
      end 
    else if (sync_clr) 
      begin
        data_out<='0;
        serial_out<='0;
      end
    else if (load) 
      begin
        data_out<= data_in;
      end
    else begin
      case(mode)
        2'b00: 
          	begin if (shift_dir==0) 
              begin
                serial_out <= data_out[width-1];
                data_out <= {data_out[width-2:0], serial_in};
              end 
             else if (shift_dir==1)
               begin
                 serial_out <= data_out[0];
                 data_out <= {serial_in, data_out[width-1:1]};
               end
            end
        2'b01:
          begin if (shift_dir==0) 
              begin
                data_out <= {data_out[width-2:0], serial_in};
              end 
             else if (shift_dir==1)
               begin
                 data_out <= {serial_in, data_out[width-1:1]};
               end
            end
        2'b10: 
          begin if (shift_dir==0) 
              begin
                serial_out <= data_out[width-1];
                data_out <= {data_out[width-2:0], 1'b0};
              end 
             else if (shift_dir==1)
               begin
                 serial_out <= data_out[0];
                 data_out <= {1'b0, data_out[width-1:1]};
               end
            end
         2'b11: 
           begin 
              data_out <= data_out;
           end 
       endcase   
    end
end
  
endmodule
