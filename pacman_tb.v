`timescale 1ns/1ns
`include "pacman.v"

module pacman_tb;

    reg clk;                  // Clock
    reg reset;                // Reset
    reg power_pellet;         // Sinal de power pellet
    wire perseguindo;         // Estado "perseguindo"
    wire assustado;           // Estado "assustado"

    // Instância do módulo a ser testado
    pacman uut (
        .clk(clk),
        .reset(reset),
        .power_pellet(power_pellet),
        .perseguindo(perseguindo),
        .assustado(assustado)
    );

    // Geração do clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Clock com período de 10 unidades de tempo
    end

    // Procedimento de teste
    initial begin
        // Inicia com reset ativado
        reset = 1;
        power_pellet = 0;
        #10;

        // Libera o reset e verifica o estado inicial
        reset = 0;
        #10;
        $display("Estado inicial: perseguindo = %b, assustado = %b", perseguindo, assustado);

        // Ativa o power pellet e verifica a transição para o estado "assustado"
        power_pellet = 1;
        #10;
        $display("Após power pellet: perseguindo = %b, assustado = %b", perseguindo, assustado);

        // Desativa o power pellet e verifica a volta ao estado "perseguindo"
        power_pellet = 0;
        #20;
        $display("Após tempo assustado: perseguindo = %b, assustado = %b", perseguindo, assustado);

        // Finaliza a simulação
        $finish;
    end

endmodule
