require 'rails_helper'

RSpec.describe "Todos", type: :request do
  let(:todo){ create(:todo)}

  describe "GET /index" do
    context "response検証" do
      before do
        Todo.create!(title: "勉強中です", description: "プログラミング学習中です", status: :done)
        get todos_path
      end

      it "status確認 200を返すこと" do
        expect(response).to have_http_status :ok
      end

      it "content_type jsonであること" do
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end

    context "jsonの検証" do
      before do
        Todo.create!(title: "勉強中です", description: "プログラミング学習中です", status: :done)
      end

      let!(:response_body) do
        get todos_path
        response.parsed_body
      end

      it "titleに適切な値があること" do
        expect(response_body[0]["title"]).to eq "勉強中です"
      end

      it "descriptionに適切な値があること" do
        expect(response_body[0]["description"]).to eq "プログラミング学習中です"
      end

      it "statusに適切な値があること" do
        expect(response_body[0]["status"]).to eq "done"
      end
    end

    context "データが存在場合" do
      before do
        get todos_path
      end

      it "データがしない" do
        expect(response.parsed_body).to eq []
      end

      it "status確認 200を返すこと" do
        expect(response).to have_http_status :ok
      end

      it "content_type jsonであること" do
        expect(response.content_type).to eq ("application/json; charset=utf-8")
      end
    end
  end

  describe "GET /show" do
    context "対象が存在している場合" do
      before do
        todo = Todo.create!(title: "勉強します", description: "基本情報技術者試験の勉強をします", status: :in_progress )
        get todos_path(id: todo.id)
      end

      it "status確認 200を返すこと" do
        expect(response).to have_http_status :ok
      end

      it "content_type jsonであること" do
        expect(response.content_type).to eq ("application/json; charset=utf-8")
      end
    end

    context "対象が存在しない場合" do
      it "ActiveRecord::RecordNotFoundを返すこと" do
        expect do
          Todo.create!(title: "筋トレします", description: "上半身を鍛えるために、3分間の筋トレをやります", status: :not_started )
          get todo_path(id: Todo.last.id + 1)
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
