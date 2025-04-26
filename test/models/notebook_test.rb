# == Schema Information
#
# Table name: notebooks
#
#  id                :integer          not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  notebookable_type :string           not null
#  notebookable_id   :integer          not null
#  user_id           :integer          not null
#  title             :string
#
# Indexes
#
#  index_notebooks_on_notebookable  (notebookable_type,notebookable_id)
#  index_notebooks_on_user_id       (user_id)
#

require "test_helper"

class NotebookTest < ActiveSupport::TestCase
  class NotebookTest < ActiveSupport::TestCase
    setup do
      @notebook_attributes = notebooks(:notebook_one).attributes.except("id", "created_at", "updated_at")
    end

    test "valid notebook with user and notebookable is valid" do
      notebook = Notebook.new(@notebook_attributes)
      assert notebook.valid?
    end

    test "invalid notebook without user" do
      notebook = Notebook.new(@notebook_attributes.merge(user_id: nil))
      assert_not notebook.valid?
    end

    test "invalid notebook without notebookable" do
      notebook = Notebook.new(@notebook_attributes.merge(notebookable_id: nil, notebookable_type: nil))
      assert_not notebook.valid?
    end
  end
end
