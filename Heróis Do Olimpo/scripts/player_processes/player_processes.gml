//coloca todas as variáveis em 0
function reset_variables() {
	left = 0;
	right = 0;
	up = 0;
	down = 0;
}

//checa se as teclas "WASD" estão sendo apertadas
function get_input() {
	if keyboard_check(ord("A")) left = 1;
	if keyboard_check(ord("D")) right = 1;
	if keyboard_check(ord("W")) up = 1;
	if keyboard_check(ord("S")) down = 1;
}

function calc_movement() {
	var _hmove = right - left;
	var _vmove = down - up;
	
//if up down left or right estão pressionados
	if _hmove != 0 or _vmove != 0 { 
		//coletar a direção de movimento
		var _dir = point_direction(0, 0, _hmove, _vmove);
		
		//coletar a distância que estamos nos movendo
		_hmove = lengthdir_x(walk_spd, _dir);
		_vmove = lengthdir_y(walk_spd, _dir);
		
		//adicionar movimento para a posição do player
		x += _hmove;
		y += _vmove;
	}
}

function collision() {
	//setar os target values
	var _tx = x;
	var _ty = y;
	
	//move para a última posição do step fora da colisão
	x = xprevious;
	y = yprevious;
	
	//pegar a distância que nós queremos nos mover
	var _disx = abs(_tx - x);
	var _disy = abs(_ty - y);
	
	//mover a maior quantidade possível antes de bater em uma parede
	repeat(_disx) {
		if !place_meeting(x + sign(_tx - x), y, o_solid) x += sign(_tx - x);
	}	
	repeat(_disy) {
		if !place_meeting(x, y + sign(_ty - y), o_solid) x += sign(_ty - y);
	}	
}