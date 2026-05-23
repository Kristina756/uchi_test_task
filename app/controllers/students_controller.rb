class StudentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    students = Student.where(class_id: params[:class_id], school_id: params[:school_id])

    render json: { data: students }
  end

  def create
    student = Student.new(student_params)

    if student.save
      secret_salt = "super_secret_key"
      token = Digest::SHA256.hexdigest("#{student.id}#{secret_salt}")

      student.update(auth_token: token)

      response.set_header("X-Auth-Token", token)
      render json: student, status: :created
    else
      render json: { error: "Invalid input" }, status: :unprocessable_entity
    end
  end

  def destroy
    student = Student.find(params[:id])

    auth_header = request.headers["Authorization"]
    token = auth_header&.split(" ")&.last

    if student.auth_token == token
      student.destroy
      render json: { message: "Deleted" }, status: :ok
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Not found" }, status: :bad_request
  end

  private

  def student_params
    params.require(:student).permit(:first_name, :last_name, :surname, :class_id, :school_id)
  end
end
