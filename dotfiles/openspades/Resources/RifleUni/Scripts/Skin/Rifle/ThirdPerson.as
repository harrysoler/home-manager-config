/*
 Copyright (c) 2013 yvt
 Modified by Paratrooper
 
 This file is part of OpenSpades.

 OpenSpades is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 OpenSpades is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with OpenSpades.  If not, see <http://www.gnu.org/licenses/>.

 */

 namespace spades {
	class ThirdPersonRifleSkin:
	IToolSkin, IThirdPersonToolSkin, IWeaponSkin, IWeaponSkin2 {
		private float sprintState;
		private float raiseState;
		private Vector3 teamColor;
		private bool muted = true;
		private Matrix4 originMatrix;
		private float aimDownSightState;
		private float readyState;
		private bool reloading;
		private float reloadProgress;
		private int ammo, clipSize;

		private float environmentRoom;
		private float environmentSize;
		private float environmentDistance;
		private Vector3 soundOrigin;

		float SprintState {
			set { sprintState = value; }
		}

		float RaiseState {
			set { raiseState = value; }
		}

		bool IsMuted {
			set { muted = value; }
		}

		Vector3 TeamColor {
			set { teamColor = value; }
		}

		Matrix4 OriginMatrix {
			set { originMatrix = value; }
		}

		float PitchBias {
			get { return 0.f; }
		}

		float AimDownSightState {
			set { aimDownSightState = value; }
		}

		bool IsReloading {
			set { reloading = value; }
		}
		float ReloadProgress {
			set { reloadProgress = value; }
		}
		int Ammo {
			set { ammo = value; }
		}
		int ClipSize {
			set { clipSize = value; }
		}

		float ReadyState {
			set { readyState = value; }
		}

		// IWeaponSkin2
		void SetSoundEnvironment(float room, float size, float distance) {
			environmentRoom = room;
			environmentSize = size;
			environmentDistance = distance;
		}
		Vector3 SoundOrigin {
			set { soundOrigin = value; }
		}

		private Renderer@ renderer;
		private AudioDevice@ audioDevice;
		private Model@ model;
		private AudioChunk@[] fireSounds(3);
		private AudioChunk@ fireFarSound;
		private AudioChunk@ fireStereoSound;
		private AudioChunk@ fireSmallReverbSound;
		private AudioChunk@ fireLargeReverbSound;
		private AudioChunk@ reloadSound;

		ThirdPersonRifleSkin(Renderer@ r, AudioDevice@ dev) {
			@renderer = r;
			@audioDevice = dev;
			@model = renderer.RegisterModel
				("Models/Weapons/Rifle/Weapon.kv6");

			@fireFarSound = dev.RegisterSound
				("Sounds/Weapons/Rifle/FireFar.wav");
			@fireStereoSound = dev.RegisterSound
				("Sounds/Weapons/Rifle/FireStereo.wav");
			@reloadSound = dev.RegisterSound
				("Sounds/Weapons/Rifle/Reload.wav");

			@fireSmallReverbSound = dev.RegisterSound
				("Sounds/Weapons/Rifle/V2AmbienceSmall.wav");
			@fireLargeReverbSound = dev.RegisterSound
				("Sounds/Weapons/Rifle/V2AmbienceLarge.wav");
		}

		void Update(float dt) {
		}

		void WeaponFired(){
			if(!muted){
				Vector3 origin = soundOrigin;
				AudioParam param;

				param.volume = 20.f * environmentRoom;
				if (environmentSize < 0.5f) {
					audioDevice.Play(fireSmallReverbSound, origin, param);
				} else {
					audioDevice.Play(fireLargeReverbSound, origin, param);
				}

				param.volume = 1.f;
				param.referenceDistance = 26.f;
				audioDevice.Play(fireFarSound, origin, param);
				param.referenceDistance = 4.f;
				param.volume = 1.f;
				audioDevice.Play(fireStereoSound, origin, param);
			}
		}

		void ReloadingWeapon() {
			if(!muted){
				Vector3 origin = soundOrigin;
				AudioParam param;
				param.volume = 0.2f;
				audioDevice.Play(reloadSound, origin, param);
			}
		}

		void ReloadedWeapon() {
		}

		void AddToScene() {
			Matrix4 mat = CreateScaleMatrix(0.03f/3.f);
			mat = mat * CreateScaleMatrix(-1.f, -1.f, 1.f);
			mat = CreateTranslateMatrix(0.4f, -0.6f, -0.1f) * mat;
			
			ModelRenderParam param;
			param.matrix = originMatrix * mat;
			renderer.AddModel(model, param);
		}
	}

	IWeaponSkin@ CreateThirdPersonRifleSkin(Renderer@ r, AudioDevice@ dev) {
		return ThirdPersonRifleSkin(r, dev);
	}
}
