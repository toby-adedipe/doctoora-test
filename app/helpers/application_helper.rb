module ApplicationHelper

	def get_doctor_name id
		#find_by_id returns nil if record not found as opposed to .find() which errors
		doctor = Doctor.find_by_id id
		if doctor
			return doctor.title + " " + doctor.first_name + " " + doctor.last_name
		else
			return "[deleted]"
		end
	end

	def get_patient_name id
		patient = User.find_by_id id
		if patient
			return patient.first_name + " " + patient.last_name
		else
			return "[deleted]"
		end
	end
	
	def greet

		current_time = Time.now.to_i
  		midnight = Time.now.beginning_of_day.to_i
  		noon = Time.now.middle_of_day.to_i
  		five_pm = Time.now.change(:hour => 17 ).to_i
  		eight_pm = Time.now.change(:hour => 20 ).to_i

  		case 
		   when midnight.upto(noon).include?(current_time)
		    return "Good Morning"
		   when noon.upto(five_pm).include?(current_time)
		    return "Good Afternoon"
		   when five_pm.upto(eight_pm).include?(current_time)
		    return "Good Evening"
		   when eight_pm.upto(midnight + 1.day).include?(current_time)
		    return "Good Night"
		end
	end

	def my_doctor_profile?
		#initially put this in doctor_profile_helper but it was not working
		#so I'm just dumping it here (for now)
		if !current_doctor
			return false
		end
		return current_doctor.id == params[:id].to_i
	end

	def unread_messages?

		if current_doctor
			id = current_doctor.id
			conversations = Conversation.where("(sender_id=? AND sender_class=?) OR (recipient_id=? AND recipient_class=?)", id, "Doctor", id, "Doctor")

			conversations.all.each do |conversation|
				if conversation.sender_unread_messages == true
					return true
				end
			end

		elsif current_user
			id = current_user.id
			conversations = Conversation.where("(recipient_id=? AND recipient_class=?) OR (sender_id=? AND sender_class=?)", id, "Patient", id, "Patient")

			conversations.all.each do |conversation|
				if conversation.unread_messages == true
					return true
				end
			end

		end
			
		return false

	end

	def get_clinic_address clinic_id
		clinic = Clinic.find clinic_id
		return clinic.name + " " + clinic.address
	end

	def get_clinic_name clinic_id
		return Clinic.find(clinic_id).name
	end

end
