class Agent::ReportController < ActionController::API
  def closed_tickets_last_month
    # TODO: authentication
    tickets = Ticket.where(state: 'Closed', created_at: Date.today.last_month.at_beginning_of_month..Date.today.at_beginning_of_month).includes(:customer, :agent).order(id: :asc)
    pdf = WickedPdf.new.pdf_from_string(report_html(tickets))
    send_data(pdf, :filename => "closed_tickets_#{Date.today.last_month.at_beginning_of_month.strftime("%Y%m")}.pdf", :disposition => 'attachment')
  end

  private

  def report_html(tickets)
    reports = ["<h1>Closed tickets last month</h1>", "<table><tr><th>index</th><th>ID</th><th>Title</th><th>Created at</th><th>Customer</th><th>Agent</th><th>Content</th></tr>"]
    tickets.each_with_index { |ticket, i| reports << "<tr><td>#{i + 1}</td><td>#{ticket.id}</td><td>#{ticket.title}</td><td>#{ticket.created_at.strftime("%-m-%-d %H:%M")}</td><td>#{ticket.customer.full_name}</td><td>#{ticket.agent.full_name}</td><td>#{ticket.content}</td></tr>" }
    reports << "</tr></table>"
    reports.join
  end
end
