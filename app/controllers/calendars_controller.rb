<%= form_with model: @plan, url: calendars_path, class: 'form' do |f| %>
  <%= f.label :date, '日付を選択', class: 'label' %>
  <%= f.date_field :date, class: 'date-select' %>
  <%= f.label :plan, '予定を入力', class: 'label' %>
  <%= f.text_field :plan, class: 'text-input' %>
  <%= f.submit '保存', class: 'submit-button' %>
<% end %>

<div class='calendar'>
  <% @week_days.each do |day| %>
    <div class='item'>
      <div class='date'>
        <%= day[:month] %>/<%= day[:date] %>
      </div>
      <ul class='content'>
        <% if day[:plans].length != 0 %>
          <% day[:plans].each do |plan| %>
            <li class='plan-list'>・<%= plan %></li>
          <% end %>
        <% end %>
      </ul>
    </div>
  <% end %>
</div>