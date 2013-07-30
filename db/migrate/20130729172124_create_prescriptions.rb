class CreatePrescriptions < ActiveRecord::Migration
  def change
    create_table :prescriptions do |t|
		t.column :eval_test_id, :integer
    	t.column :exercise_id, :integer
      t.timestamps
    end
  end
end
