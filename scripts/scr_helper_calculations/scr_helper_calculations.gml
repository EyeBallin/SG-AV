/// @param {Struct.infoAttackComponent} sourceInfo Attack Info
/// @param {Id.Instance<obj_abs_entity>} owner Owning entity
/// @param {Id.Instance<obj_abs_dmg>} damagingObject The damaging object
function calcDamageScalings(sourceInfo, owner, damagingObject) {
	var dmgScalings = sourceInfo.attCompScaling;
  var scalingVals = variable_struct_get_names(dmgScalings);

  for (var i = 0; i < array_length(scalingVals); i += 1) {
    var scalingKey = scalingVals[i];
    var gotScaling = dmgScalings[$ scalingKey];
		if (gotScaling == 0) {
			continue;
		}
    switch (scalingKey) {
      case "scalePhys":
        damagingObject.projDmgVal += owner.getStatDmgPhys().getStatCurr() * gotScaling;
        break;
      case "scaleEner":
        damagingObject.projDmgVal += owner.getStatDmgEner().getStatCurr() * gotScaling;
        break;
      case "scaleHPCurr":
        damagingObject.projDmgVal += owner.getStatHP().getStatCurr() * gotScaling;
        break;
      case "scaleHPMax":
        damagingObject.projDmgVal += owner.getStatHP().eStatCalcMax * gotScaling;
        break;
      case "scaleHPMissing":
        damagingObject.projDmgVal += (owner.getStatHP().eStatCalcMax - owner.getStatHP().getStatCurr()) * gotScaling;
        break;
      case "scaleEnemyHPCurr":
        damagingObject.projDmgEnemyHPScaleCurr += gotScaling;
        break;
      case "scaleEnemyHPMax":
        damagingObject.projDmgEnemyHPScaleMax += gotScaling;
        break;
      case "scaleEnemyHPMissing":
        damagingObject.projDmgEnemyHPScaleMiss += gotScaling;
        break;
      case "scaleManaCurr":
        damagingObject.projDmgVal += owner.getStatMana().getStatCurr() * gotScaling;
        break;
      case "scaleManaMax":
        damagingObject.projDmgVal += owner.getStatMana().eStatCalcMax * gotScaling;
        break;
      case "scaleManaMissing":
        damagingObject.projDmgVal += (owner.getStatMana().eStatCalcMax - owner.getStatMana().getStatCurr()) * gotScaling;
        break;
      case "scaleAttSpeed":
        damagingObject.projDmgVal += owner.getStatSpdAtt().getStatCurr() * gotScaling;
        break;
    }
  }
}