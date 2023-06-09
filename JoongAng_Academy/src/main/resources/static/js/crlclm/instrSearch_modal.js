$(function(){
		// -- 교육과정 모달창 검색값 가져가기
		$("#depSearch").off().click(function(){
			var department = $("#department").val();
			if(department != ""){
				$("#dep_Search_text").val(department);
				$('#depShow').click();
				$("#SearchModal").modal("show");
				
			} else {
				$("#SearchModal").modal("show");
			}
				
			
		});
		
		//모달 띄울때 그리드 새로고침
		$('#SearchModal').on('shown.bs.modal', function(e) {
			grid2.refreshLayout();
		})
		
		//교육과정 검색
			$(document).on("click",'#depShow', function(){
				$("#depChoose").attr("disabled", false);
				let dep_searchs = $("#dep_Search_text").val();
				//alert(dep_searchs);
				
				$.post({
					url : "/depsearch",
					data:{
						"depsearchs" : dep_searchs
					},
					cache : false,
					dataType : "json"
				}).done(function(data){
					grid2.refreshLayout();
					var result2 = data.list2;
					//alert("!");
					grid2.resetData(result2);
					let selectedRowKey = null;
					grid2.on('focusChange', (ev) => {
						  grid2.setSelectionRange({
						    start: [ev.rowKey, 0],
						    end: [ev.rowKey, grid2.getColumns().length]
						  });						
					});
					grid2.on('click', () => {
						const rowKey = grid2.getFocusedCell().rowKey;
						var obj = grid2.getRow(rowKey);
						var keys = Object.values(obj);
						var code_num = keys[0];
						var code_name = keys[1];
						//alert(rowKey);
						$("#depChoose").off().on("click",function(){
							//alert(keys);
							$("#inputGroup-sizing-sm").text(code_num);
							$("#department").val(code_name);
							$("#SearchModal").modal("hide");

						});
					});
					
				}).fail(function() {
					alert("문제가 발생했습니다.");
				});
	
			});
			
		//화면 끌 경우 초기화
		$('#SearchModal').on('hidden.bs.modal', function(e) {
		    	$("#dep_Search_text").val('');
				$("#depChoose").attr("disabled", true);
				$("#searchGrid").find('td').empty();
				grid2.off('click');
		});

		
		
		
	var Grid = tui.Grid;
		
		Grid.applyTheme('clean', { 
			  row: { 
				    hover: { 
				      background: '#e9ecef' 
				    }
				  }
				});
		
	
		
		var grid2 = new tui.Grid({
		      el: document.getElementById('searchGrid'),
		      bodyHeight: 350,
		      scrollX: true,
		      scrollY: true,
		      contextMenu: null,
		      rowHeaders: ['checkbox'],
		      columns: [
		        {
		          header: '코드',
		          name: 'CRCLM_CD',
		          width:120,
		          align:'center'
		        },
		        {
		          header: '교육과정명',
		          name: 'CRCLM_CD_NAME',
		          width:350,
		          align:'center'
		        },
		        {
		          header: '년도',
		          name: 'CRCLM_YEAR',
		          width:120,
		          align:'center'
		        },
		        {
		          header: '교육분기',
		          name: 'CRCLM_HALF',
		          width:120,
		          align:'center'
		        }
				],
			selectionUnit: 'row'
			
			});
			
		 
			 
});