class DoctorOnboardingController < ApplicationController

	def new
		@lgas = User::LGAS
		@states = User::STATES
		@doctor = Doctor.find(current_doctor.id)
		
		@clinical_specialty_list = Doctor::CLINICAL_SPECIALTY_LIST

		@non_clinical_specialty_list = Doctor::NON_CLINICAL_SPECIALTY_LIST
	end

	def create
		@doctor = Doctor.find(current_doctor)
    	@doctor.update(onboarding_params)

    	Wallet.create(doctor_id: @doctor.id, balance: 0)
    	
    	redirect_to doctor_onboarding_new_upload_documents_path
	end

	def upload_documents
		@doctor = Doctor.find(current_doctor.id)
	end

	def submit_documents
		doctor = Doctor.find(current_doctor.id)
		doctor.update(doctor_params)

		if doctor.save
			redirect_to root_path
		else
			flash[:notice] = "There was an error uploading your documents. Please ensure files are PDF or Word documents"
			redirect_to :back
		end
	end

	private

	def onboarding_params
		params.require(:doctor).permit(:dob, :gender, :ethnicity, :specialization, :specialty, 
									   :house, :state, :town, :postcode, :country, :avatar, :registration_fee,
									   :home_consultation_fee, :video_consultation_fee, :clinic_visit_fee)
	end

	def doctor_params
		params.require(:doctor).permit(:mdcn, :nysc, :uni_cert, :post_nysc, :id_proof)
	end

end