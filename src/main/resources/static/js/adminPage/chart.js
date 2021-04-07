chartDefault = () => {
	$.ajax({
		url: contextPath + '/admin/getChart',
		type: 'GET',
		success: function(data) {
			var chartName = new Array;
			var chartNameCount = new Array;
			for (var i = 0; i < data.length; i++) {
				chartName.push(data[i].lclas);
				chartNameCount.push(data[i].categoryCount);
			}
			var ctx = document.getElementById('myChart').getContext('2d');
			var myChart = new Chart(ctx, {
				type: 'bar',
				data: {
					labels: chartName,
					datasets: [{
						label: '카테고리 별 Count',
						data: chartNameCount,
						backgroundColor: [
							'rgba(255, 99, 132, 0.2)',
							'rgba(54, 162, 235, 0.2)',
							'rgba(255, 206, 86, 0.2)',
							'rgba(75, 192, 192, 0.2)',
							'rgba(153, 102, 255, 0.2)',
							'rgba(255, 99, 132, 0.2)',
							'rgba(54, 162, 235, 0.2)',
							'rgba(255, 206, 86, 0.2)',
							'rgba(75, 192, 192, 0.2)',
							'rgba(153, 102, 255, 0.2)',
						],
						borderColor: [
							'rgba(255, 99, 132, 1)',
							'rgba(54, 162, 235, 1)',
							'rgba(255, 206, 86, 1)',
							'rgba(75, 192, 192, 1)',
							'rgba(153, 102, 255, 1)',
							'rgba(255, 99, 132, 1)',
							'rgba(54, 162, 235, 1)',
							'rgba(255, 206, 86, 1)',
							'rgba(75, 192, 192, 1)',
							'rgba(153, 102, 255, 1)',
						],
					}]
				}
			});
		}
	});
}