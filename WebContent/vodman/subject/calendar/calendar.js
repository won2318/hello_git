//날짜 입력을 위한 달력을 생성한다.
Calendar.count = 0

var	strCalendarButton			=  "./calendar/img/btn_calendar.gif";
var	strCalendarButtonDown		=  "./calendar/img/btn_calendar_d.gif";

// Calendar 객체를 생성한다.
// divname - 캘린더가 표시될 레이어
// objPutDate - 선택된 날짜를 받아갈 입력 폼을 지정한다.
// objPutWeekStart - 선택된 날짜에 해당하는 주의 시작일을 받아갈 입력 폼을 지정한다.
// objPutWeekEnd   - 선택된 날짜에 해당하는 주의 마지막일을 받아갈 입력 폼을 지정한다.
// strWeekMode     - 값이 입력되면 선택된 주가 표시되는 모드
function Calendar(divname, objPutDate, objPutWeekStart, objPutWeekEnd, strWeekMode)
{
	this.name = "Calendar"+(Calendar.count++)
	this.obj = this.name + "Object"
	eval(this.obj + "=this")
	this.divMain = divname
	this.divCaledar = divname
	this.txtPutDate = objPutDate
	this.txtPutWeekStart = objPutWeekStart
	this.txtPutWeekEnd = objPutWeekEnd
	this.weekMode = strWeekMode
}
{
	var p = Calendar.prototype
	p.active = false
	p.CalendarCreate = CalendarCreate
	p.setDate = CalendarSetDate
	p.CalendarGetDate = CalendarGetDate
	p.onClick = CalendarOnClick
	p.show = CalendarShow
	p.changeMonth = CalendarChangeMonth
	p.changeYear  = CalendarChangeYear
	p.onChange = CaledarOnChange
	p.formatDate = CalendarFormatDate
	p.parseDate = CalendarParseDate
	p.buildWithButton = CalendarBuildWithButton
	p.buildWithTextButton = CalendarBuildWithTextButton
	p.getWeekStartDate = CalendarGetWeekStartDate
	p.getWeekEndDate = CalendarGetWeekEndDate
	p.formatDisplay = CalendarFormatDisplay
	p.displayText	= CalendarDisplayText
}

function CalendarCreate()
{
	if (this.divCaledar == null) {
		return;
	}

	var	strHTML;
	strHTML =
		"<TABLE class=clsCalendarTitle cellspacing=0>"
		+ "<TR>"
		+ "<TD class=clsCalendarTitleButton align=left width=5% onclick='"+this.obj+".changeYear(-1)'>"
		+ "◀"
		+ "</TD>"
		+ "<TD class=clsCalendarTitleButton align=center width=5% onclick='"+this.obj+".changeMonth(-1)'>"
		+ "≪"
		+ "</TD>"
		+ "<TD class=clsCalendarTitle align=center width=80%>"
		+ "</TD>"
		+ "<TD class=clsCalendarTitleButton align=center width=5% onclick='"+this.obj+".changeMonth(1)'>"
		+ "≫"
		+ "</TD>"
		+ "<TD class=clsCalendarTitleButton align=right width=5% onclick='"+this.obj+".changeYear(1)'>"
		+ "▶"
		+ "</TD>"
		+ "</TR>"
		+ "</TABLE>";

	strHTML += "<TABLE cellspacing=0 cellspacing=0 onclick='"+this.obj+".onClick()'>";
	strHTML +=
		"<TR>"
		+ "<TD width=1%>&nbsp;</TD>"
		+ "<TD class=clsCalendarTitleSun width=14% align=center>일</TD>"
		+ "<TD width=14% align=center>월</TD>"
		+ "<TD width=14% align=center>화</TD>"
		+ "<TD width=14% align=center>수</TD>"
		+ "<TD width=14% align=center>목</TD>"
		+ "<TD width=14% align=center>금</TD>"
		+ "<TD class=clsCalendarTitleSat width=14% align=center>토</TD>"
		+ "<TD width=1%>&nbsp;</TD>"
		+ "</TR>";
	// 빈셀들을 만든다.
	for (var i = 0; i < 6; i++) {
		strHTML += "<TR>";
		strHTML += "<TD>&nbsp;</TD>"
		for (var j = 0; j < 7; j++) {
			strHTML += "<TD align=center></TD>";
		}
		strHTML += "<TD>&nbsp;</TD>"
		strHTML += "</TR>";
	}
	strHTML += "</TABLE>";

	this.divCaledar.innerHTML = strHTML;
}

function CalendarSetDate(dtDate, dtSelected)
{
	var	dtTemp			= new Date(dtDate.getFullYear(), dtDate.getMonth(), 1, 0, 0, 0);
	var	tblCalendar	= this.divCaledar.children[1];
	var	rwsCalendar	= tblCalendar.rows;
	var	cllsCalendar;

	this.dtDate	= new Date(dtDate);
	//	현재의 년도와 월을 표시한다.
	this.divCaledar.children[0].rows[0].cells[2].innerHTML = dtTemp.getFullYear() + "년 " + (dtTemp.getMonth() + 1) + "월";

	// 현재표시되는 달의 첫번째 날짜를 가져온다.
	dtTemp.setDate(dtTemp.getDate() - dtTemp.getDay());

	this.dtStart = new Date(dtTemp);
	for (var i = 1; i < 7; i++) {
		cllsCalendar = rwsCalendar[i].cells;
		for (var j = 1; j < 8; j++) {
			cllsCalendar[j].innerHTML = dtTemp.getDate();
			//	각셀의 서식을 적용한다.
			if (dtTemp.getMonth() == this.dtDate.getMonth()) {
				if (dtSelected != null && dtSelected.getYear() == dtTemp.getYear() &&
					dtSelected.getMonth() == dtSelected.getMonth() &&
					dtSelected.getDate() == dtTemp.getDate())
				{
					if (j==1)
						cllsCalendar[j].className = "clsCalendarDaySelectedSun";
					else if (j==7)
						cllsCalendar[j].className = "clsCalendarDaySelectedSat";
					else
						cllsCalendar[j].className = "clsCalendarDaySelected";
					this.cllSelected = cllsCalendar[j];
					this.cllsSelected = cllsCalendar[j].parentElement.cells;
				}
				else {
					if (j==1)
						cllsCalendar[j].className = "clsCalendarDaySun";
					else if (j==7)
						cllsCalendar[j].className = "clsCalendarDaySat";
					else
						cllsCalendar[j].className = "clsCalendarDay";
				}
				cllsCalendar[j].orgClass		= "clsCalendarDay";
			}
			else {
				cllsCalendar[j].className = "clsCalendarDayTailing";
				cllsCalendar[j].orgClass	= "clsCalendarDayTailing";
			}
			dtTemp.setDate(dtTemp.getDate() + 1);
		}
	}
	this.dtEnd = new Date(dtTemp);

	if (this.cllsSelected != null && this.weekMode != null ) {
		for (var i = 1; i < 8; i++) {
					if (this.cllsSelected[i].className == "clsCalendarDayTailing") {
						this.cllsSelected[i].className = "clsCalendarWeekTailing";
						continue;
					}
					if (i==1)
						this.cllsSelected[i].className = "clsCalendarWeekSelectedSun";
					else if (i==7)
						this.cllsSelected[i].className = "clsCalendarWeekSelectedSat";
					else
						this.cllsSelected[i].className = "clsCalendarWeekSelected";
		}
	}
}

function CalendarGetWeekStartDate(cllDate)
{
	var	strClass	= cllDate.className;
	var	nDay		= new Number(cllDate.innerHTML);

	switch (strClass) {
		case "clsCalendarDay" :
		case "clsCalendarDaySelected" :
		case "clsCalendarWeekSelected" :
		case "clsCalendarDaySun" :
		case "clsCalendarDaySelectedSun" :
		case "clsCalendarWeekSelectedSun" :
			this.dtWeekStartDate = new Date(this.dtDate.getFullYear(), this.dtDate.getMonth(), nDay, 0, 0, 0);
			return;

		case "clsCalendarDayTailing" :
		case "clsCalendarWeekTailing" :
			this.dtWeekStartDate	= new Date(this.dtDate.getFullYear(), this.dtDate.getMonth() - 1, nDay, 0, 0, 0);
			return;
	}
}

function CalendarGetWeekEndDate(cllDate)
{
	var	strClass	= cllDate.className;
	var	nDay		= new Number(cllDate.innerHTML);

	switch (strClass) {
		case "clsCalendarDay" :
		case "clsCalendarDaySelected" :
		case "clsCalendarWeekSelected" :
		case "clsCalendarDaySat" :
		case "clsCalendarDaySelectedSat" :
		case "clsCalendarWeekSelectedSat" :
			this.dtWeekEndDate = new Date(this.dtDate.getFullYear(), this.dtDate.getMonth(), nDay, 0, 0, 0);
			return;

		case "clsCalendarDayTailing" :
		case "clsCalendarWeekTailing" :
			this.dtWeekEndDate	= new Date(this.dtDate.getFullYear(), this.dtDate.getMonth() + 1, nDay, 0, 0, 0);
			return;
	}
}

function CalendarGetDate(cllDate)
{
	var	strClass	= cllDate.className;
	var	cllsDate	= cllDate.parentElement.cells;
	var	nDay		= new Number(cllDate.innerHTML);
	var	nMonth;

	switch (strClass) {
		case "clsCalendarDay" :
		case "clsCalendarDaySelected" :
		case "clsCalendarWeekSelected" :
			cllDate.className	= "clsCalendarDaySelected";
			this.dtSelected		= new Date(this.dtDate.getFullYear(), this.dtDate.getMonth(), nDay, 0, 0, 0);
			this.dtDate			  = new Date(this.dtDate.getFullYear(), this.dtDate.getMonth(), nDay,  0, 0, 0);
			this.cllSelected	= cllDate;
			this.getWeekStartDate(cllsDate[1])
			this.getWeekEndDate(cllsDate[7]);
			return this.dtDate;

		case "clsCalendarDaySat" :
		case "clsCalendarDaySelectedSat" :
		case "clsCalendarWeekSelectedSat" :
			cllDate.className	= "clsCalendarDaySelectedSat";
			this.dtSelected		= new Date(this.dtDate.getFullYear(), this.dtDate.getMonth(), nDay, 0, 0, 0);
			this.dtDate			  = new Date(this.dtDate.getFullYear(), this.dtDate.getMonth(), nDay,  0, 0, 0);
			this.cllSelected	= cllDate;
			this.getWeekStartDate(cllsDate[1])
			this.getWeekEndDate(cllsDate[7]);
			return this.dtDate;

		case "clsCalendarDaySun" :
		case "clsCalendarDaySelectedSun" :
		case "clsCalendarWeekSelectedSun" :
			cllDate.className	= "clsCalendarDaySelectedSun";
			this.dtSelected		= new Date(this.dtDate.getFullYear(), this.dtDate.getMonth(), nDay, 0, 0, 0);
			this.dtDate			  = new Date(this.dtDate.getFullYear(), this.dtDate.getMonth(), nDay,  0, 0, 0);
			this.cllSelected	= cllDate;
			this.getWeekStartDate(cllsDate[1])
			this.getWeekEndDate(cllsDate[7]);
			return this.dtDate;

		case "clsCalendarDayTailing" :
		case "clsCalendarWeekTailing" :
			if (nDay > 8) {
				nMonth = this.dtDate.getMonth() - 1;
			}
			else {
				nMonth = this.dtDate.getMonth() + 1;
			}
			this.getWeekStartDate(cllsDate[1])
			this.getWeekEndDate(cllsDate[7]);
			this.dtDate	= new Date(this.dtDate.getFullYear(), nMonth, nDay, 0, 0, 0);

			return this.dtDate;
	}

	return null;
}

function CalendarOnClick()
{
	var	el				= window.event.srcElement;
	var	dtDate;

	dtDate = this.CalendarGetDate(el);
	if (dtDate == null) {
		return;
	}

	if (this.txtDate != null)
		this.formatDisplay(this.txtDate, this.dtDate);

	if (this.txtWeekStart != null)
		this.formatDisplay(this.txtWeekStart, this.dtWeekStartDate);

	if (this.txtWeekEnd != null)
		this.formatDisplay(this.txtWeekEnd, this.dtWeekEndDate);

	this.onChange();
	this.show()
}

function CalendarShow()
{

	if (!this.active) {
		this.CalendarCreate()
		this.divCaledar.className = "clsCalendar"
	}

	if (this.divCaledar.style.visibility == "visible") {
		
		if (this.divMain != null)
			this.divMain.style.zIndex = 0 
					
		if (this.btnImage != null)
			this.btnImage.src = strCalendarButton

		this.divCaledar.style.visibility	= "hidden";
	}
	else
	{
		if (this.txtPutDate != null) {
			this.dtDate = this.parseDate(this.txtPutDate.value)
		}
		else if (txtPutWeekStart != null) {
			this.dtDate = this.parseDate(this.txtPutWeekStart.value)
		}

		if (this.dtDate == null) {
			this.dtDate = new Date();
		}

		this.setDate(this.dtDate, this.dtDate);

		if (this.btnImage != null)
			this.btnImage.src = strCalendarButtonDown

		if (this.divMain != null)
			this.divMain.style.zIndex = this.divCaledar.style.zIndex  + 100 
		
		this.divCaledar.style.visibility	= "visible";		
	}
}

function CalendarChangeMonth(dm)
{
	var	dtTemp		= this.dtDate;
	var	nMonth		= dtTemp.getMonth();
	var	nDiff_shit;

	dtTemp.setMonth(nMonth + dm);

	nDiff_shit	= dtTemp.getMonth() - nMonth;
	nDiff_shit	= nDiff_shit == 11 ? -1 : nDiff_shit;
	nDiff_shit	= nDiff_shit == -11 ? 1 : nDiff_shit;

	if (nDiff_shit != dm) {
		dtTemp.setMonth(dtTemp.getMonth() - (nDiff_shit - dm));
	}

	this.setDate(dtTemp);
}

function CalendarChangeYear(dy)
{
	var	dtTemp		= this.dtDate;
	var	nYear		  = dtTemp.getFullYear();
	var	nMonth		= dtTemp.getMonth();
	var	nDiff_shit;

	dtTemp.setYear(nYear + dy);

	nDiff_shit	= dtTemp.getMonth() - nMonth;
	nDiff_shit	= nDiff_shit == 11 ? -1 : nDiff_shit;
	nDiff_shit	= nDiff_shit == -11 ? 1 : nDiff_shit;

	if (nDiff_shit != 0) {
		dtTemp.setMonth(dtTemp.getMonth() - nDiff_shit);
	}

	this.setDate(dtTemp);
}

function CaledarOnChange()
{
	if (this.txtPutDate != null)
	{
		this.txtPutDate.value = this.formatDate(this.dtDate)
	}
	if (this.txtPutWeekStart != null)
	{
		this.txtPutWeekStart.value = this.formatDate(this.dtWeekStartDate)
	}
	if (this.txtPutWeekEnd != null)
	{
		this.txtPutWeekEnd.value = this.formatDate(this.dtWeekEndDate)
	}
}

function CalendarFormatDisplay(txtDate, dtTemp)
{
	if (dtTemp == null) return;
	txtDate.value = dtTemp.getFullYear() + "년 " + (dtTemp.getMonth() + 1) + "월 " + dtTemp.getDate() + "일";
}

function CalendarFormatDate(dtDate)
{
	var strTemp;
	strTemp = "" + dtDate.getFullYear()

	if (dtDate.getMonth() < 9)
		strTemp += "0"
	strTemp += "" + (dtDate.getMonth()+1)

	if (dtDate.getDate() < 10)
		strTemp += "0"
	strTemp += "" + dtDate.getDate()

	return strTemp;
}

// yyyymmdd 형식의 문자열을 날짜로 변환한다.
function CalendarParseDate(str)
{
	var dtTemp;
	var	nYear		= 0;
	var	nMonth	= 0;
	var	nDay		= 0;

	if (str == null || str.length == 0) return;

	if (str.length > 7)
	{
		nYear = new Number(str.substr(0,4));
		nMonth = new Number(str.substr(4,2));
		nDay = new Number(str.substr(6));
	}
	else
	{
		if (str.length > 4)
		{
			nYear = new Number(str.substr(0,4));
			nMonth = new Number(str.substr(4));
			nDay	 = 1;
		}
		else
		{
			nYear  = new Number(str);
			nMonth = 1;
			nDay 	 = 1;
		}
  }

	if ((nYear*10000+nMonth*100+nDay) > 10101) {
		dtTemp = new Date(nYear, nMonth -1, nDay, 0, 0, 0);
	}
	else {
		return null
	}

	return dtTemp;
}

function CalendarBuildWithButton()
{
	var	strHTML		= "";
	var	strDatePick	= "";

	strHTML +=
		"<IMG"
		+ " src=" + strCalendarButton
		+ " align=absmiddle"
		+ " onclick='"+this.obj+".show()'"
		+ " />"
		+ "<DIV>";
	strHTML += "</DIV>";
	
	this.divMain.innerHTML = strHTML;
	this.divCaledar.className = "clsCalendarWithButton"
	this.btnImage = this.divMain.children[0];
	this.divCaledar = this.divMain.children[1];

	return null;
}

function CalendarBuildWithTextButton()
{
	var	strHTML		= "";
	var	strDatePick	= "";

	strHTML +=
		"<INPUT type=text"
		+ " class=clsCalendarTextBox"
		+ " readOnly"
		+ " />"
	if (this.weekMode != null) {
		strHTML +=
			" ~ <INPUT type=text"
			+ " class=clsCalendarTextBox"
			+ " readOnly"
			+ " />"
	}
	strHTML +=
		 "<IMG"
		+ " src=" + strCalendarButton
		+ " align=absmiddle"
		+ " onclick='"+this.obj+".show()'"
		+ " />"
		+ "<DIV>";
		
	strHTML += "</DIV>";

	this.divMain.innerHTML = strHTML;
	this.divCaledar.className = "clsCalendarWithButton"

	if (this.weekMode != null) {
		this.txtWeekStart = this.divMain.children[0];
		this.txtWeekEnd = this.divMain.children[1];
		this.btnImage   = this.divMain.children[2];
		this.divCaledar = this.divMain.children[3];
	}
	else {
		this.txtDate = this.divMain.children[0];
		this.btnImage   = this.divMain.children[1];
		this.divCaledar = this.divMain.children[2];
	}

	this.displayText()

	return null;
}

function CalendarDisplayText()
{
	if (this.txtPutDate != null) {
		this.dtDate = this.parseDate(this.txtPutDate.value)
	}
	if (this.txtPutWeekStart != null) {
		this.dtWeekStartDate = this.parseDate(this.txtPutWeekStart.value)
	}
	if (this.txtPutWeekEnd != null) {
		this.dtWeekEndDate = this.parseDate(this.txtPutWeekEnd.value)
	}

	if (this.txtDate != null)
		this.formatDisplay(this.txtDate, this.dtDate);

	if (this.txtWeekStart != null)
		this.formatDisplay(this.txtWeekStart, this.dtWeekStartDate);

	if (this.txtWeekEnd != null)
		this.formatDisplay(this.txtWeekEnd, this.dtWeekEndDate);
}