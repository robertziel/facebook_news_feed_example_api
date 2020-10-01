shared_examples :graphql_record_not_found_error do
  it 'returns RECORD_NOT_FOUND_ERROR' do
    result = graphql!['errors'].any? do |error|
      error['extensions']['code'] == GraphQL::Errors::RECORD_NOT_FOUND_ERROR
    end
    expect(result).to eq(true)
  end
end
