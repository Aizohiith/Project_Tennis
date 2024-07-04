shader_type particles;

void start() {
	VELOCITY.x = 100.0;
	
}

void process() {
	VELOCITY.x = VELOCITY.x + 1.0;
	if (TRANSFORM[3].x > 1000.0)
		ACTIVE = false;
	// Called every frame on existing particles (according to the Fixed FPS property).
}
