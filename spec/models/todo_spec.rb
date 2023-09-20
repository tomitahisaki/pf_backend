# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Todo do
  describe 'バリデーションテスト' do
    let(:todo) { create(:todo) }

    context 'すべて入力されている場合' do
      it 'バリデーションに合格する' do
        expect(todo).to be_valid
      end
    end

    context 'title' do
      it '未入力の場合' do
        todo.title = ''
        expect(todo).not_to be_valid
      end

      it '50文字以内の場合' do
        todo.title = 'a' * 50
        expect(todo).to be_valid
      end

      it '51文字以上の場合' do
        todo.title = 'a' * 51
        expect(todo).not_to be_valid
      end
    end

    context 'description' do
      it '未入力の場合' do
        todo.description = ''
        expect(todo).not_to be_valid
      end

      it '9文字の場合' do
        todo.description = 'a' * 9
        expect(todo).not_to be_valid
      end

      it '10文字の場合' do
        todo.description = 'a' * 10
        expect(todo).to be_valid
      end

      it '500文字の場合' do
        todo.description = 'a' * 500
        expect(todo).to be_valid
      end

      it '501文字の場合' do
        todo.description = 'a' * 501
        expect(todo).not_to be_valid
      end
    end
  end
end
