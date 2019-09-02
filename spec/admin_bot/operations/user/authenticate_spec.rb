RSpec.describe AdminBot::Op::User::Authenticate do
  let(:result) { described_class.call(user: user) } 

  describe 'user role' do
    context 'when not approved' do
      let(:user) { Fabricate(:admin_bot_user, role: AdminBot::User::Roles.not_approved) }
      it { expect(result.success?).to be_falsey }
    end
  
    context "when is moderator" do
      let(:user) { Fabricate(:admin_bot_user, role: AdminBot::User::Roles.moderator) }
      it { expect(result.success?).to be_truthy }
    end

    context "when is administrator" do
      let(:user) { Fabricate(:admin_bot_user, role: AdminBot::User::Roles.administrator) }
      it { expect(result.success?).to be_truthy }
    end
  end
end

