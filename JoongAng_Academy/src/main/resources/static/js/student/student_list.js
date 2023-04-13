$(function(){
	
		
		$("#stuSearch").click(function(){
			let department = $(".department-code").text();
			let status = $("select[name=status]").val();
			let year = $.trim($("#year").val());
			let turn = $("select[name=turn]").val();
			let nameAndNum = $.trim($("#nameAndNum").val());
			let gender = $("select[name=gender]").val();
		
			$.post({
				url : "/studentSearch",
				data:{
					"department" : department,
    				"status" : status,
					"year":year,
					"turn":turn,
					"nameAndNum":nameAndNum,
					"gender":gender
				},
				cache : false,
				dataType : "json"
			}).done(function(data){
				var result = data.list;
				//alert(result[0].ZIP);
				grid.resetData(result);
				let selectedRowKey = null;
				grid.on('focusChange', (ev) => {
					  grid.setSelectionRange({
					    start: [ev.rowKey, 0],
					    end: [ev.rowKey, grid.getColumns().length]
					  });
				});
				
			}).fail(function() {
				alert("문제가 발생했습니다.");
			});
			
		});
		
	var Grid = tui.Grid;
		
		Grid.applyTheme('clean', { 
			  row: { 
				    hover: { 
				      background: '#e9ecef' 
				    }
				  }
				});
		
	
		
		var grid = new tui.Grid({
		      el: document.getElementById('grid'),
		      bodyHeight: 420,
		      scrollX: true,
		      scrollY: true,
		      contextMenu: null,
		      rowHeaders: ['checkbox'],
		      columns: [
		        {
		          header: '학번',
		          name: 'APPL_NO',
		          width:150,
		          align:'center'
		        },
		        {
		          header: '이름',
		          name: 'KORN_FLNM',
		          width:120,
		          align:'center'
		        },
		        {
		          header: '생년월일',
		          name: 'USER_BRDT',
		          width:120,
		          align:'center'
		        },
		        {
		          header: '성별',
		          name: 'GENDER_CD_NAME',
		          width:100,
		          align:'center'
		        },
		       
				{
					header : '나이',
					name : 'AGE',
					width:100,
			        align:'center'
				}, 
				{
					header : '연락처',
					name : 'TELNO',
					width:150,
				    align:'center'
				},
				{
					header : '비상연락처',
					name : 'REL_TELNO',
					width:150,
				    align:'center'
				}, 
				{
					header : '학적상태',
					name : 'REG_CD_NAME',
					width:100,
				    align:'center'
				},
				{
					header : '학과코드',
					name : 'CRCLM_CD',
					width:120,
				    align:'center'
				},
				{
					header : '소속학과명',
					name : 'CRCLM_CD_NAME',
					width:350,
				    align:'center'
				},
				{
					header : '교육년도',
					name : 'CRCLM_YEAR',
					width:120,
				    align:'center'
				},
				{
					header : '교육반기',
					name : 'CRCLM_HALF_NAME',
					width:120,
				    align:'center'
				},
				{
					header : 'Email',
					name : 'EML_ADDR',
					width:160,
				    align:'center'
				},
				{
					header : '우편번호',
					name : 'ZIP',
					width:120,
				    align:'center'
				},
				{
					header : '주소',
					name : 'ADDR',
					width:380,
				    align:'center'
				}
				],
			selectionUnit: 'row'
			
			});
		 
			 
});