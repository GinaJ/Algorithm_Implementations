1)modificare il numero di bit per i decimali, parte intera e lunghezza del vettore input X 
nei file delle costanti "myType.vhd", e nei file in matlab "cosine_matrix.m" e "after_dct.m"
2)lanciare  "cosine_matrix.m" che genera la matrice dei coseni
3)lanciare il testbench. nel testbench si scrive l'input x in un'unica riga, ricordando che ogni valore di x è un intero con n bit (definito nelle costanti)
ex: X=[1;2;3;4] n_bit_integer=16 ==> X_vector<=x"0001000200030004";
4)il testbench genera un file binario di output "matrix_dct_TB.txt"
5)lanciare "after_dct.m" che genera il file "matrix_res_dct_matlab.txt". Converte il risultato da binario a decimale.
6)per verifica, scrivere in matlab il vettore e farne poi il dct
ex: 
X=[1;2;3;4]
dct(X)
7)I risultati possono essere non uguali per problemi di approssimazione da parte di matlab o da parte del vhdl (ex:poca precisione: pochi bit per i float).