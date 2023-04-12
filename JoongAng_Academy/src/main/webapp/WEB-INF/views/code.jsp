<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<!-- JQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<title>중앙정보처리학원</title>
<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
	rel="stylesheet" />
<link href="css/styles.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
</head>
<style type="text/css">
.btns {

float:right;

}
button {
border:1px solid gray;
}
</style>
<body class="sb-nav-fixed">
	<%@include file="./bar/topbar.jsp"%>
	<div id="layoutSidenav">
	<%@include file="./bar/sidebar.jsp"%>
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<h1 class="mt-4">공통코드관리</h1>
					
					
					<div class="btns mb-2">
						<button id="new">신규</button>
						<button id="delet">삭제</button>
						<button id="sync">저장</button>
					</div>
					
					<div id="grid"></div>
					
					
					
					
				
				</div>
			</main>
			<%@include file="./bar/footer.jsp" %>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="js/scripts.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
		crossorigin="anonymous"></script>
	<script src="assets/demo/chart-area-demo.js"></script>
	<script src="assets/demo/chart-bar-demo.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
		crossorigin="anonymous"></script>
	<script src="js/datatables-simple-demo.js"></script>
	
	
<!-- TOAST UI Grid -->
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>

<!-- TOAST UI Grid js -->
<script type="text/javascript">
		
/*  const dataSource = {
		 contentType: 'application/json',
		  api: {
		    readData: { url: '/api/readData', method: 'GET' },
		    createData: { url: '/api/createData', method: 'POST' },
		    updateData: { url: '/api/updateData', method: 'PUT' },
		    modifyData: { url: '/api/modifyData', method: 'PUT' },
		    deleteData: { url: '/api/deleteData', method: 'DELETE' }
		  }
		};
		
function syncServer() {
	  const net = grid.getAddOn('Net');

	  net.request('updateData', {
	    checkedOnly: false
	  });
	}
document.getElementById('sync').addEventListener('click', syncServer) */
		
		
/* class CustomTextEditor {
    constructor(props) {
      const el = document.createElement('input');
      const { maxLength } = props.columnInfo.editor.options;

      el.type = 'text';
      el.maxLength = maxLength;
      el.value = String(props.value);

      this.el = el;
    }

    getElement() {
      return this.el;
    }

    getValue() {
      return this.el.value;
    }

    mounted() {
      this.el.select();
    }
  } */

$(function(){
	

	$(function() {
		$.post({
			url : "/codeListAjax",
			dataType : "json"
		}).done(function(data) {
      	  grid.resetData(data.list);
		}).fail(function() {
			alert("문제가 발생했습니다.");
		});
		const Grid = tui.Grid;
        Grid.applyTheme('clean');
   
        
		var grid = new tui.Grid({
			el : document.getElementById('grid'),
			scrollX : false,
			scrollY : true,
			bodyHeight: 250,
			rowHeaders : [ 'checkbox' ],
			  columns: [
			      {
			        header: '코드분류',
			        name: 'CD_CLSF',
			        editor: {
					 type: CustomTextEditor,
				      options: {
				      maxLength: 4
				          }
				        }
			      },
			      {
			        header: '코드',
			        name: 'CD',
			        editor: {
						 type: CustomTextEditor,
					      options: {
					      maxLength: 4
					          }
					        }
			      },
			      {
			        header: '코드명',
			        name: 'CD_NM',
			        formatter: 'listItemText',
			        editor: {
						 type: CustomTextEditor,
					      options: {
					      maxLength: 4
					          }
					        }
			      },
			      {
			        header: '코드사용여부',
			        name: 'CD_USE_YN',
			        formatter: 'listItemText',
			        editor: {
			          type: 'radio',
			          options: {
				            listItems: [
				              { text: 'Y', value: '1' },
				              { text: 'N', value: '2' }
				            ]
				          }
			        },
			        copyOptions: {
			          useListItemText: true // when this option is used, the copy value is concatenated text
			        }
			      },
			      {
			        header: '코드설명',
			        name: 'CD_EXPLN',
			        copyOptions: {
			          useListItemText: true
			        },
			        formatter: 'listItemText',
			        editor: {
						 type: CustomTextEditor,
					      options: {
					      maxLength: 4
					          }
					        }
			      },
			      {
			          header: '코드정렬일련번호',
			          name: 'CD_SORT_SN',
			          formatter: 'listItemText',
			          editor: {
							 type: CustomTextEditor,
						      options: {
						      maxLength: 4
						          }
						        },
			          copyOptions: {
			            useListItemText: true // when this option is used, the copy value is concatenated text
			          }
			        }]
		});
	});
		
		
		
	/* 	const gridData = [
		      {
		        name: 'CD_CLSF',
		        artist: 'Birdy',
		        release: '2016.03.26',
		        type: 'Deluxe',
		        genre: 'Pop'
		      },
		      {
		        name: 'CD',
		        artist: 'Ed Sheeran',
		        release: '2014.06.24',
		        type: 'Deluxe',
		        genre: 'Pop',
		        _attributes: {
		          disabled: true // A current row is disabled
		        }
		      },
		      {
		        name: 'CD_NM',
		        release: '2011.08.08',
		        artist: 'Maroon5',
		        type: 'Single',
		        genre: 'Pop,Rock',
		        _attributes: {
		          checkDisabled: true // A checkbox is disabled only
		        }
		      },
		      {
		        name: 'CD_USE_YN',
		        artist: 'Coldplay',
		        release: '2015.12.04',
		        type: 'Deluxe',
		        genre: 'Rock',
		        _attributes: {
		          checked: true, // A checkbox is already checked while rendering
		          className: {
		            // Add class name on a row
		            row: ['red']
		          }
		        }
		      },
		      {
		        name: 'CD_EXPLN',
		        artist: 'Adele',
		        release: '2008.01.27',
		        type: 'EP',
		        genre: 'Pop,R&B',
		        _attributes: {
		          rowSpan: {
		            // Merge rows
		            artist: 3,
		            genre: 2
		          }
		        }
		      },
		      {
		        name: 'CD_SORT_SN',
		        artist: 'Adele',
		        release: '2011.01.21',
		        type: 'Deluxe',
		        genre: 'Pop,R&B'
		      }
		    ]; */
		
		/*  const grid = new tui.Grid({
			    el: document.getElementById('grid'),
			    scrollX: false,
			    scrollY: false,
			    columns: [
			      {
			        header: '코드분류',
			        name: 'CD_CLSF',
			        editor: {
					 type: CustomTextEditor,
				      options: {
				      maxLength: 4
				          }
				        }
			      },
			      {
			        header: '코드',
			        name: 'CD',
			        editor: {
						 type: CustomTextEditor,
					      options: {
					      maxLength: 4
					          }
					        }
			      },
			      {
			        header: '코드명',
			        name: 'CD_NM',
			        formatter: 'listItemText',
			        editor: {
						 type: CustomTextEditor,
					      options: {
					      maxLength: 4
					          }
					        }
			      },
			      {
			        header: '코드사용여부',
			        name: 'CD_USE_YN',
			        formatter: 'listItemText',
			        editor: {
			          type: 'radio',
			          options: {
				            listItems: [
				              { text: 'Y', value: '1' },
				              { text: 'N', value: '2' }
				            ]
				          }
			        },
			        copyOptions: {
			          useListItemText: true // when this option is used, the copy value is concatenated text
			        }
			      },
			      {
			        header: '코드설명',
			        name: 'CD_EXPLN',
			        copyOptions: {
			          useListItemText: true
			        },
			        formatter: 'listItemText',
			        editor: {
						 type: CustomTextEditor,
					      options: {
					      maxLength: 4
					          }
					        }
			      },
			      {
			          header: '코드정렬일련번호',
			          name: 'CD_SORT_SN',
			          formatter: 'listItemText',
			          editor: {
							 type: CustomTextEditor,
						      options: {
						      maxLength: 4
						          }
						        },
			          copyOptions: {
			            useListItemText: true // when this option is used, the copy value is concatenated text
			          }
			        }]
			  }); //grid

		  	  grid.on('beforeChange', ev => {
			    console.log('before change:', ev);
			  });
			  grid.on('afterChange', ev => {
			    console.log('after change:', ev);
			  })
			  grid.resetData(result);
	}// suc
}); //ajax
 
}); */


</script>
</body>
</html>
