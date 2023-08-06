`timescale 1ns / 1ps




module maze(
	input clk,
	input [maze_width - 1:0]  starting_col, starting_row, 	// indicii punctului de start
	input maze_in, 			// ofera informatii despre punctul de coordonate [row, col]
	output reg [maze_width - 1:0] row, col,	 		// selecteaza un rând si o coloana din labirint
	output reg maze_oe,			// output enable (activeaza verificarea din labirint la rândul si coloana date) - semnal sincron	
	output reg maze_we, 			// write enable (activeaza scrierea în labirint la rândul si coloana date) - semnal sincron
	output reg done); // iesirea din labirint a fost gasita; semnalul ramane activ 


	parameter maze_width = 6;

	`define init 0
	`define verif_jos 1
	`define verif_dreapta 3
	`define verif_sus 5
	`define verif_stanga 7
	`define iesire 9
	
	always @(posedge clk) begin
			state <= state_next;
	end
	
	reg [3:0] state = `init;
	reg [3:0] state_next = `init;
	reg [1:0] t = 0;
	
	always @(*) begin

		maze_oe = 0;
		maze_we = 0;
		case(state)
			`init: begin
				row = starting_row;
				col = starting_col;
				maze_we = 1;			
				state_next = `verif_jos;
				if ((row == 63) || (row == 0) || (col == 63) || (col == 0)) begin
					state_next = `iesire;
					done = 1;
				end
			end
				
			
			`verif_jos: begin
				row = row + 1;
				maze_oe = 1;
				state_next = `verif_jos + 1;
			end

			`verif_jos + 1: begin
				if (maze_in == 0) begin
					state_next = `verif_stanga;
					maze_we = 1;
					t = 0;
					if ((row == 63) || (row == 0) || (col == 63) || (col == 0)) begin
						state_next = `iesire;
						done = 1;
					end
				end
				else if (maze_in == 1) begin
					row = row - 1;
					state_next = `verif_dreapta + 1;
					maze_oe = 1;
					col = col + 1;
					t = t + 1;
					if (t == 3) begin
						maze_we = 1;
						t = 0;
						state_next = `verif_jos;
						if ((row == 63) || (row == 0) || (col == 63) || (col == 0)) begin
							state_next = `iesire;
							done = 1;
						end
					end
				end	
			end
			
			
			`verif_dreapta: begin
				col = col + 1;
				maze_oe = 1;
				state_next = `verif_dreapta + 1;
			end

			`verif_dreapta + 1: begin
				if (maze_in == 0) begin
					state_next = `verif_jos;
					maze_we = 1;
					t = 0;
					if ((row == 63) || (row == 0) || (col == 63) || (col == 0)) begin
						state_next = `iesire;
						done = 1;

					end
				end
				else if (maze_in == 1) begin
					col = col - 1;
					state_next = `verif_sus + 1;
					maze_oe = 1;
					row = row - 1;
					t = t + 1;
					if (t == 3) begin
						maze_we = 1;
						t = 0;
						state_next = `verif_dreapta;
						if ((row == 63) || (row == 0) || (col == 63) || (col == 0)) begin
							state_next = `iesire;
							done = 1;
						end
					end
				end
			end
			
			`verif_sus: begin
				row = row - 1;
				maze_oe = 1;
				state_next = `verif_sus + 1;
			end

			`verif_sus + 1: begin
				if (maze_in == 0) begin
					state_next = `verif_dreapta;
					maze_we = 1;
					t = 0;
					if ((row == 63) || (row == 0) || (col == 63) || (col == 0)) begin
						state_next = `iesire;
						done = 1;
					end
				end
				else if (maze_in == 1) begin
					row = row + 1;
					state_next = `verif_stanga + 1;
					maze_oe = 1;
					col = col - 1;
					t = t + 1;
					if (t == 3) begin
						maze_we = 1;
						t = 0;
						state_next = `verif_sus;
						if ((row == 63) || (row == 0) || (col == 63) || (col == 0)) begin
							state_next = `iesire;
							done = 1;
						end
					end
				end
			end
			
			`verif_stanga: begin
				col = col - 1;
				maze_oe = 1;
				state_next = `verif_stanga + 1;
			end

			`verif_stanga + 1: begin
				if (maze_in == 0) begin
					state_next = `verif_sus;
					maze_we = 1;
					t = 0;
					if ((row == 63) || (row == 0) || (col == 63) || (col == 0)) begin
						state_next = `iesire;
						done = 1;
					end
				end
				else if (maze_in == 1) begin
					col = col + 1;
					state_next = `verif_jos + 1;
					maze_oe = 1;
					row = row + 1;
					t = t + 1;
					if (t == 3) begin
						maze_we = 1;
						t = 0;
						state_next = `verif_stanga;
						if ((row == 63) || (row == 0) || (col == 63) || (col == 0)) begin
							state_next = `iesire;
							done = 1;
						end
					end
				end
			
			end
				
			`iesire: begin
			end			
		
		endcase 
				
	end 

endmodule







