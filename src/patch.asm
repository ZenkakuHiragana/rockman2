;����ƈ�v���Ȃ��f�[�^�Ȃǂ��C�����邽�߂̃t�@�C���B

;��~���̃I�u�W�F�N�g�̏����A�h���X�ŕςȕ���������
;9489
	.bank $1C
	.org $9489
	.db $E6

;�����蔻��e�[�u���̏C��
;D4E1
	.bank $1E
	.org Table_CollisionSizeX + $0A
	.db $09
	.org Table_CollisionSizeX + CollisionDataLength * 2 + $10
	.db $0A

;�A�j���[�V�����̃|�C���^�̏C��
;F900
	.bank $1E
	.org Table_AnimationPointerEnemy_Low + $4D
	.db LOW(en35)
	.org Table_AnimationPointerEnemy_Low + $52
	.db LOW(en50)
	.org Table_AnimationPointerEnemy_Low + $57
	.db LOW(en2F)
	.org Table_AnimationPointerEnemy_Low + $67
	.db LOW(en1C)
	.org Table_AnimationPointerEnemy_High + $67
	.db HIGH(en1C)
	.org Table_AnimationPointerEnemy_Low + $6F
	.db LOW(en35)
	.org Table_AnimationPointerEnemy_High + $6F
	.db HIGH(en35)
