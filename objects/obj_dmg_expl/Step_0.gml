explTimer += 1;
explTimePerc = explTimer/explDur;
if (explTimePerc < 0.35)
	explColCurr = merge_colour(explColA, explColB, explTimePerc/0.35);
else if (explTimePerc >= 0.35 && explTimePerc < 0.85)
	explColCurr = merge_color(explColB, explColC, (explTimePerc - 0.35)/0.5);
else if (explTimePerc >= 0.85)
	explColCurr = explColC;

switch (explDmgType) {
	case dmgExplTypeEnum.explPulse:
		explAlphaCurr = 1 - explTimePerc;
		explScaleCurr = 1;
		break;
	case dmgExplTypeEnum.explBoom:
	default:
		explAlphaCurr = max(0, 1-(explTimePerc*1));
		explScaleCurr = min(1, explTimePerc * 2);
		break;
}

if (explTimePerc >= 1)
	instance_destroy();