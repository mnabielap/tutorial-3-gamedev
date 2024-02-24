Saya memilih mengimplementasikan dua fitur tambahan yang diberikan, yakni

- Double jump - karakter pemain bisa melakukan aksi loncat sebanyak dua kali.<br>
Pada fitur ini, saya mengimplementasikan code berikut<br>
```
	...
	velocity.x = 0
	if is_on_floor() and Input.is_action_just_pressed('up'):
		jumps = 0
		velocity.y = jump_speed
		jumps += 1
	if not is_on_floor() and jumps < max_jumps and Input.is_action_just_pressed('up'):
		velocity.y = jump_speed
		jumps += 1
	...
```
Jadi ketika berada di lantai, maka akan direset jumlah jumpnya, lalu lompat dan jump increment.
Setelahnya, ketika tidak menyentuh lantai, dan ketika jumlah jump saat ini masih kurang dari max, maka bisa jump lagi

- Dashing - karakter pemain dapat bergerak lebih cepat dari kecepatan biasa secara sementara ketika pemain menekan tombol space.<br>
Ini adalah code untuk dash,
```
	if Input.is_action_just_pressed("ui_select") and not is_dashing:
		is_dashing = true
		dash_timer = dash_duration
	if is_dashing:
		velocity.x = -dash_speed if Input.is_action_pressed('left') else dash_speed
		dash_timer -= get_process_delta_time()
		if dash_timer <= 0:
			is_dashing = false
	if not is_dashing and Input.is_action_pressed('right'):
		velocity.x += speed
	if not is_dashing and Input.is_action_pressed('left'):
		velocity.x -= speed
```
Jadi, ketika dipencet tombol SPACEBAR, maka pemain akan berlari dengan cepat (dash).
Disini, saya juga mengimplementasikan timer dash 
