flowerPrts = [];
prtCount = 10;
randTint = random_range(0, 0.25);
for (var i = 0; i < prtCount; i += 1) {
	flowerPrts[i] = {
		sizeMult: 1 - (i * 0.1),
		sineMult: i * 0.1 + 0.2,
		colMult: merge_colour(#4e875a, #FFFFFF, min(i * 0.1 + randTint, 1)),
		currRot: 0
	}
}
sineStep = irandom(360);
sineSpeed = random_range(0.25, 0.5);
randSize = random_range(0.3, 1);
randAngle = random(360);
randAlpha = random_range(0.1, 0.2);