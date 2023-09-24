# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Todos' do
  let(:todo) { create(:todo) }

  describe 'GET /index' do
    context 'response検証' do
      before do
        Todo.create!(title: '勉強中です', description: 'プログラミング学習中です', status: :done)
        get todos_path
      end

      it 'status確認 200を返すこと' do
        expect(response).to have_http_status :ok
      end

      it 'content_type jsonであること' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'jsonの検証' do
      before do
        Todo.create!(title: '勉強中です', description: 'プログラミング学習中です', status: :done)
      end

      let!(:response_body) do
        get todos_path
        response.parsed_body
      end

      it 'titleに適切な値があること' do
        expect(response_body[0]['title']).to eq '勉強中です'
      end

      it 'descriptionに適切な値があること' do
        expect(response_body[0]['description']).to eq 'プログラミング学習中です'
      end

      it 'statusに適切な値があること' do
        expect(response_body[0]['status']).to eq 'done'
      end
    end

    context 'データが存在する場合' do
      before do
        get todos_path
      end

      it 'データがしない' do
        expect(response.parsed_body).to eq []
      end

      it 'status確認 200を返すこと' do
        expect(response).to have_http_status :ok
      end

      it 'content_type jsonであること' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'GET /show' do
    context '対象が存在している場合' do
      before do
        todo = Todo.create!(title: '勉強します', description: '基本情報技術者試験の勉強をします', status: :in_progress)
        get todos_path(id: todo.id)
      end

      it 'status確認 200を返すこと' do
        expect(response).to have_http_status :ok
      end

      it 'content_type jsonであること' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context '対象が存在しない場合' do
      it 'ActiveRecord::RecordNotFoundを返すこと' do
        expect do
          Todo.create!(title: '筋トレします', description: '上半身を鍛えるために、3分間の筋トレをやります', status: :not_started)
          get todo_path(id: Todo.last.id + 1)
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'POST /create' do
    let(:create_todo_params) do
      {
        todo: {
          title: 'テストタイトル 筋トレします',
          description: 'テスト用ディスクリプション 筋トレします',
          status: 'not_started',
        },
      }
    end

    context '正常な場合' do
      before do
        post todos_path, params: create_todo_params
      end

      it 'titleが登録されていること' do
        expect(Todo.last['title']).to eq 'テストタイトル 筋トレします'
      end

      it 'descriptionが登録されていること' do
        expect(Todo.last['description']).to eq 'テスト用ディスクリプション 筋トレします'
      end

      it 'statusが登録されていること' do
        expect(Todo.last['status']).to eq 'not_started'
      end

      it 'status確認 200を返すこと' do
        expect(response).to have_http_status :ok
      end
    end

    context '正常ではない場合' do
      it 'titleが空白の場合、作成できない' do
        expect do
          not_create_params = { todo: { title: '', description: 'RubySilverの資格勉強をしています', status: 'not_started' } }
          post todos_path, params: not_create_params
        end.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe 'PATCH /update' do
    context '正常な場合' do
      it '更新できること' do
        todo = Todo.create!(title: 'Rubyの勉強', description: 'RubySilverの資格勉強をしています', status: 'not_started')

        update_params = { todo: { status: 'done' } }
        patch todo_path(id: todo.id),
              params: update_params

        expect(todo.reload.status).to eq 'done'
        expect(response).to have_http_status :ok
      end
    end

    context '正常ではない' do
      it '更新できないこと' do
        expect do
          Todo.create!(title: 'Rubyの勉強', description: 'RubySilverの資格勉強をしています', status: 'not_started')
          update_params = { todo: { description: '' } }
          patch todo_path(id: todo.id), params: update_params
        end.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe 'DELETE /destroy' do
    context '正常に削除される場合' do
      let!(:todo) { create(:todo) }

      it '削除対象が存在する場合' do
        expect do
          delete todo_path(id: todo.id)
        end.to change(Todo, :count).by(-1)

        expect(response).to have_http_status :ok
      end
    end

    context '正常に削除されない場合' do
      let!(:todo) { create(:todo) }

      it '削除対象が存在しない場合、例外が発生する' do
        expect do
          delete todo_path(id: todo.id + 1)
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
