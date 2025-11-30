window.onload = carregarDashboard;

function carregarDashboard() {
    const idUsuario = sessionStorage.ID_USUARIO;

    if (!idUsuario) {
        console.error("ID do usuário não encontrado na sessão.");
        return;
    }

    fetchAproveitamento(idUsuario);
    fetchMelhorPontuacao(idUsuario);
    fetchHistorico(idUsuario);
}

function fetchAproveitamento(idUsuario) {
    fetch(`/kpis/aproveitamento/${idUsuario}`)
        .then(resposta => {
            if (resposta.status == 204) {
                return null; 
            }
            return resposta.json();
        })
        .then(dados => {
            if (dados && dados.length > 0) {
                const resultado = dados[0];

                const totalRespostas = resultado.total_respostas || 0;
                const totalCertas = resultado.total_certas || 0;
                const totalErradas = resultado.total_erradas || 0;

                let Acertos = 0;
                if (totalRespostas > 0) {
                    Acertos = (totalCertas);
                }
                
                
                const totalTentativas = totalRespostas; 

                document.getElementById('kpi_tentativas').innerHTML = totalTentativas;
                document.getElementById('kpi_aproveitamento').innerHTML = `${Acertos}`;

                criarGraficoPizza(totalCertas, totalErradas);
            } else {
               
                document.getElementById('kpi_tentativas').innerHTML = "0";
                document.getElementById('kpi_aproveitamento').innerHTML = "0%";
                criarGraficoPizza(0, 0);
            }
        })
        .catch(erro => console.error("Erro no aproveitamento:", erro));
}

function fetchMelhorPontuacao(idUsuario) {
    fetch(`/kpis/melhor-pontuacao/${idUsuario}`)
        .then(resposta => {
            if (resposta.status == 204) return null;
            return resposta.json();
        })
        .then(dados => {
            if (dados && dados.length > 0 && dados[0].maior_acerto !== null) {
                const melhorPontuacao = dados[0].maior_acerto;
                document.getElementById('kpi_melhor_pontuacao').innerHTML = `${melhorPontuacao} / 20`; 
            } else {
                document.getElementById('kpi_melhor_pontuacao').innerHTML = "0 / 20";
            }
        })
        .catch(erro => console.error("Erro na melhor pontuação:", erro));
}

function fetchHistorico(idUsuario) {
    fetch(`/kpis/historico/${idUsuario}`)
        .then(resposta => {
            if (resposta.status == 204) return [];
            return resposta.json();
        })
        .then(dados => {
            if (dados && dados.length > 0) {
                
                
                const dadosInvertidos = dados.reverse();
                
                const labels = dadosInvertidos.map(item => item.label_data);
                const pontuacoes = dadosInvertidos.map(item => item.pontuacao);

                criarGraficoHistorico(labels, pontuacoes);
            } else {
                criarGraficoHistorico([], []);
            }
        })
        .catch(erro => console.error("Erro no histórico:", erro));
}


function criarGraficoPizza(acertos, erros) {
    const canvas = document.getElementById('graficoPizzaAcertos');
    if(!canvas) return; 
    
    if (window.myPieChart) window.myPieChart.destroy();

    const ctx = canvas.getContext('2d');
    window.myPieChart = new Chart(ctx, {
        type: 'pie',
        data: {
            labels: ['Acertos', 'Erros'],
            datasets: [{
                data: [acertos, erros],
                backgroundColor: ['#178b17ff', '#800000'],
                hoverOffset: 4
            }]
        },
        options: { responsive: true, maintainAspectRatio: false }
    });
}

function criarGraficoHistorico(labels, pontuacoes) {
    const canvas = document.getElementById('graficoHistorico');
    if(!canvas) return;

    if (window.myLineChart) window.myLineChart.destroy();

    const ctx = canvas.getContext('2d');
    window.myLineChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: 'Acertos por tentativa',
                data: pontuacoes,
                backgroundColor: 'rgba(17, 87, 17, 0.5)',
                tension: 0.3
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: { beginAtZero: true, max: 20 }
            }
        }
    });
}