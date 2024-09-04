module pacman(
    input wire clk,         // Clock
    input wire reset,       // Reset
    input wire power_pellet,// Sinal de power pellet (ativa o estado "assustado")
    output reg perseguindo, // Estado "perseguindo"
    output reg assustado    // Estado "assustado"
);

    // Definição dos estados
    localparam PERSEGUINDO = 2'b00;// Estado "perseguindo"
    localparam ASSUSTADO = 2'b01; // Estado "assustado"

    reg [1:0] estado_atual, estado_proximo;

    // Lógica de transição de estados
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            estado_atual <= PERSEGUINDO; // Reset para o estado inicial "perseguindo"
        end else begin
            estado_atual <= estado_proximo;
        end
    end

    // Lógica de definição do próximo estado
    always @(*) begin
        // Por padrão, mantém o estado atual
        estado_proximo = estado_atual;
        case (estado_atual)
            PERSEGUINDO: begin
                if (power_pellet) begin
                    estado_proximo = ASSUSTADO; // Transição para o estado "assustado"
                end
            end
            ASSUSTADO: begin
                // Após o tempo de susto, volta a perseguir (pode adicionar um temporizador aqui)
                estado_proximo = PERSEGUINDO;
            end
        endcase
    end

    // Lógica de saída (definição dos estados de saída)
    always @(*) begin
        // Reseta os sinais de saída
        perseguindo = 1'b0;
        assustado = 1'b0;

        case (estado_atual)
            PERSEGUINDO: begin
                perseguindo = 1'b1; // Ativa o sinal "perseguindo"
            end
            ASSUSTADO: begin
                assustado = 1'b1; // Ativa o sinal "assustado"
            end
        endcase
    end

endmodule
