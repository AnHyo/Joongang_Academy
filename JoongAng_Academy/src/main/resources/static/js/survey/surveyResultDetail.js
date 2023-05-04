$(function() {
	//grid hover
	const Grid = tui.Grid;
	Grid.applyTheme('clean', { 
		  row: { 
			    hover: { 
			      background: '#e9ecef' 
			    }
			  }
	});	
	
	
	//keydown함수	

	const grid1_columns = [
	  {key: 'name', name: 'Name'},
	  {key: 'age', name: 'Age'},
	  {key: 'gender', name: 'Gender'},
	];
	
	var grid1 = new tui.Grid({
		el : document.getElementById('grid1'),
		scrollX : false,
		scrollY : true,
		bodyHeight : 250,
		rowHeaders: [
		        {
		            type: 'rowNum',
		            header: 'No.',
		        }
		    ],
		columns : grid1_columns
	});
	
	//결과조회 띄우기
	$.post({
			url : "/surveyResult",
			dataType : "json",
				data : { "s_CRCLM_YEAR" : s_CRCLM_YEAR}
			}).done(function(data) {
				grid.resetData(data.list);
			}).fail(function() {
				alert("문제가 발생했습니다.");
	});
	
	
	
	var grid2 = new tui.Grid({
		el : document.getElementById('grid2'),
		scrollX : false,
		scrollY : true,
		bodyHeight : 250,
		/* rowHeaders: [
		        {
		            type: 'rowNum',
		            header: 'No.',
		        }
		    ],*/
		columns : [ 
		{
			header : '학번',
			name : 'DGSTFN_CN',
			width: 70,
			align : 'center',
			sortable: true,
		    sortingType: 'desc'
		}, {
			header : '성명',
			name : 'CRCLM_HALF_NM',
			width: 60,
			align : 'center',
			sortable: true,
		    sortingType: 'desc'
		}, 
		{
			header : '1번',
			name : 'CRCLM_CD_NM',
			align : 'center',
			sortable: true,
		    sortingType: 'desc'
		}, 
		{
			header : '여자',
			name : 'SBJCT_NM',
			width: 150,
			align : 'center',
			sortable: true,
		    sortingType: 'desc'
		},
		{
			header : '남자',
			name : 'DGSTFN_SDATE',
			width: 110,
			align : 'center',
			sortable: true,
		    sortingType: 'desc'
		}]
	});
	
	
	

});