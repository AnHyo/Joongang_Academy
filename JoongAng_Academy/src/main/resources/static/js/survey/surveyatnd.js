$(function() {	
	//applinfoview
	var grid3 = new tui.Grid({
		el : document.getElementById('grid3'),
		scrollX : false,
		scrollY : true,
		bodyHeight: 150,
		rowHeaders : [ 'checkbox' ],
		columns : [ 
			{
				header : '사용자번호',
				name : 'USER_NO',
				width: 100,
				align : 'center',
				editor: 'text'
			}, {
				header : '성명',
				name : 'KORN_FLNM',
				width: 700,
				align : 'center',
				editor: 'text'
			}, {
				header : '훈련과정',
				name : 'CRCLM_NM',
				width: 200,
				align : 'center'
			}, {
				header : '휴대전화',
				name : 'TELNO',
				width: 100,
				align : 'center',
				editor: 'text'
			}],
	});
});