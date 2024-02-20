module TasksHelper
  def priorityColor(priority)
    case priority
    when "high"
      "bg-red-500 text-white"
    when "medium"
      "bg-yellow-500 text-black"
    when "low"
      "bg-green-500 text-white"
    else
      ""
    end
  end
end