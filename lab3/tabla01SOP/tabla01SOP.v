module tabla01SOP();

// SOP del tabla01SOP

  reg A, B, C;
  wire w1, w2, w3, w4, w5, out, wa, wb, wc;

  // not (salida, entrada);
  // and (salida, entrada1, entrada2, entrada3, etc);
  
  not U1(wa, A);
  not U2(wb, B);
  not U3(wc, C);
  and U4(w1, wa, wb, wc);
  and U5(w2, wa, B, wc);
  and U6(w3, A, wb, wc);
  and U7(w4, A, wb, C);
  and U8(w5, A, B, C);
  or U9(out, w1, w2, w3, w4, w5);


  initial begin
    $display("A B C | Y");
    $display("-------");
    $monitor("%b %b %b | %b", A, B, C, out);
    A = 0; B = 0; C=0;
    #1 C = 1;
    #1 B = 1;
    C = 0;
    #1 B = 1;
    C = 1;
    #1 A = 1;
    B = 0;
    C = 0;
     #1 C = 1;
    #1 B = 1;
    C = 0;
    #1 B = 1;
    C = 1;
    #1 $finish;
  end

  initial begin
      $dumpfile("tabla01SOP.vcd"); 
      $dumpvars(0, tabla01SOP);
    end 

endmodule	