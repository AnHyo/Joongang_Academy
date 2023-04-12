$(function(){
		$(".stuSearch").click(function(){
			let department = $("#department").val();
			let status = $("select[name=status]").val();
			let year = $("#year").val();
			let turn = $("select[name=turn]").val();
			let nameAndNum = $("#nameAndNum").val();
			let gender = $("select[name=gender]").val();
			//alert(department + "  ::  " + status + " :: " + year + " :: " + turn);
			//alert(nameAndNum + " :: " + gender);
			
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
				
				
			});
			
		});
		
		
		 var gridData = [
		      {
		    	  id: '0000909',
		        name: 'Beautiful Lies',
		        artist: 'Birdy',
		        birth: '2016.03.26',
		        gender: '여자',
		        age: '28',
		        tel: '010-2223-4445',
		        eTel: '010-2223-4495',
		        status:'훈련중',
		        depCode:'0204930',
		        depName: '자바(JAVA)기반 풀스택 개발자 취업과정',
		        eduYear: '2022',
		        turn: '상반기',
		        email:'stu001@gmail.com',
		        postNum:'16502',
		        add:'경기도 어딘가 좋은동 좋은아파트 102동 102호'
		      },
		      {
		        name: 'X',
		        artist: 'Ed Sheeran',
		        birth: '2014.06.24',
		        type: 'Deluxe',
		        genre: 'Pop',
		        _attributes: {
		          disabled: true // A current row is disabled
		        }
		      },
		      {
		        name: '25',
		        artist: 'Adele',
		        birth: '2015.11.20',
		        type: 'EP',
		        genre: 'Pop',
		        _attributes: {
		          className: {
		            // Add class name on each columns
		            column: {
		              type: ['blue'],
		              genre: ['blue']
		            }
		          }
		        }
		      }
		    ];
		
		var grid = new tui.Grid({
		      el: document.getElementById('grid'),
		      data: gridData,
		      bodyHeight: 500,
		      scrollX: true,
		      scrollY: true,
		      contextMenu: null,
		      rowHeaders: ['checkbox'],
		      columns: [
		        {
		          header: '학번',
		          name: 'id',
		          width:150,
		          align:'center'
		        },
		        {
		          header: '이름',
		          name: 'name',
		          width:120,
		          align:'center'
		        },
		        {
		          header: '생년월일',
		          name: 'birth',
		          width:120,
		          align:'center'
		        },
		        {
		          header: '성별',
		          name: 'gender',
		          width:100,
		          align:'center'
		        },
		       
				{
					header : '나이',
					name : 'age',
					width:100,
			        align:'center'
				}, 
				{
					header : '연락처',
					name : 'tel',
					width:150,
				    align:'center'
				},
				{
					header : '비상연락처',
					name : 'eTel',
					width:150,
				    align:'center'
				}, 
				{
					header : '학적상태',
					name : 'status',
					width:100,
				    align:'center'
				},
				{
					header : '학과코드',
					name : 'depCode',
					width:120,
				    align:'center'
				},
				{
					header : '소속학과명',
					name : 'depName',
					width:280,
				    align:'center'
				},
				{
					header : '교육년도',
					name : 'eduYear',
					width:120,
				    align:'center'
				},
				{
					header : '교육회차',
					name : 'turn',
					width:100,
				    align:'center'
				},
				{
					header : 'Email',
					name : 'email',
					width:160,
				    align:'center'
				},
				{
					header : '우편번호',
					name : 'postNum',
					width:120,
				    align:'center'
				},
				{
					header : '주소',
					name : 'add',
					width:300,
				    align:'center'
				}
				]
			});
		 
			 
});