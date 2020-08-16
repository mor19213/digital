module tabla04POS();

// POS del tabla04

  reg A, B, C, D;
  wire w1, w2, w3, w4, w5, w6, w7, w8, w9, out, wa, wb, wc, wd;

  // not (salida, entrada);
  // and (salida, entrada1, entrada2, entrada3, etc);
  
  not U1(wa, A);
  not U2(wb, B);
  not U3(wc, C);
  not U4(wd, D);
  or U5(w1, A, B, C, wd);
  or U6(w2, A, wb, C, D);
  or U7(w3, A, wb, C, wd);
  or U8(w4, wa, B, C, wd);
  or U9(w5, wa, B, wc, wd);
  or U10(w6, wa, wb, C, D);
  or U11(w7, wa, wb, C, wd);
  or U12(w8, wa, wb, wc, D);
  or U13(w9, wa, wb, wc, wd);
  and U14(out, w1, w2, w3,w4, w5, w6, w7, w8, w9);


  initial begin
    $display("A B C D| Y");
    $display("-------");
    $monitor("%b %b %b %b| %b", A, B, C, D, out);
    A = 0; B = 0; C=0; D=0;
    #1 D = 1;
    #1 C = 1; D = 0;
    #1 D = 1;
    #1 B = 1; C = 0; D = 0;
    #1 D = 1;
    #1 C = 1; D = 0;
    #1 D = 1;
    #1 A = 1; B = 0; C = 0; D = 0;
    #1 D = 1;
    #1 C = 1; D = 0;
    #1 D = 1;
    #1 B = 1; C = 0; D = 0;
    #1 D = 1;
    #1 C = 1; D = 0;
    #1 D = 1;
    #1 $finish;
  end

  initial begin
      $dumpfile("tabla04POS.vcd"); 
      $dumpvars(0, tabla04POS);
    end 

endmodule	