module tabla03SOP();

// POS del tabla03

  reg A, B, C, D;
  wire w1, w2, w3, w4, w5, w6, w7, out, wa, wb, wc, wd;

  // not (salida, entrada);
  // and (salida, entrada1, entrada2, entrada3, etc);
  
  not U1(wa, A);
  not U2(wb, B);
  not U3(wc, C);
  not U4(wd, D);
  and U5(w1, wa, wb, wc, wd);
  and U6(w2, wa, wb, wc, D);
  and U7(w3, wa, wb, C, wd);
  and U8(w4, wa, wb, C, D);
  and U9(w5, A, wb, wc, wd);
  and U10(w6, A, wb, C, wd);
  and U11(w7, A, B, C, wd);
  or U12(out, w1, w2, w3, w4, w5, w6, w7);


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

  initial 
    begin
      $dumpfile("tabla03SOP.vcd"); 
      $dumpvars(0, tabla03SOP);
    end 

endmodule	