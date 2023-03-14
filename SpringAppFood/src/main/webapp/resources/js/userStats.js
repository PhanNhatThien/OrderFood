/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


function uStats(labels, data) {
    const ctx = document.getElementById('myChart3').getContext('2d');
    const myChart3 = new Chart(ctx, {
        type: 'pie',
        data: {
            labels: labels,
            datasets: [{
                    label: 'Tổng sản phẩm kinh doanh của cửa hàng ',
                    data: data,
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(153, 102, 255, 0.2)',
                        'rgba(255, 159, 64, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)'
                    ],
                    borderWidth: 1
                }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
}
function generateColors() {
    let r = parseInt(Math.random() * 255);
    let g = parseInt(Math.random() * 255);
    let b = parseInt(Math.random() * 255);
    return `rgb(${r}, ${g}, ${b})`
}

function userRoleChart(id, userRoleLabels = [], userRoleInfos = []) {
    let colors = []
    for (let i = 0; i < userRoleLabels.length; i++)
        colors.push(generateColors())

    const data = {
        labels: userRoleLabels,
        datasets: [{
            label: 'Thống kê số lượng các tài khoản được tạo theo loại tài khoản',
            data: userRoleInfos,
            backgroundColor: colors,
            hoverOffset: 4
        }]
    };

    const config = {
        type: 'pie',
        data: data,
    };

    let ctx = document.getElementById(id).getContext("2d")
    new Chart(ctx, config)
}
function refreshPage() {
    window.location.reload();
}