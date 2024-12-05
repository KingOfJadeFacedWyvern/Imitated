
import { LiveInfoDataModel } from './LiveDataModel';

export const LiveData: Array<LiveInfoDataModel> = [
  { uri: $rawfile('video1.mp4'),
    name: $r('app.string.first_author'),
    peopleNum: '520',
    commentList: [
      {
        name: $r('app.string.first_one_name'),
        comment: $r('app.string.first_one_comment')
      },
      {
        name: $r('app.string.first_two_name'),
        comment: $r('app.string.first_two_comment')
      },
      {
        name: $r('app.string.first_three_name'),
        comment: $r('app.string.first_three_comment')
      },
      {
        name: $r('app.string.first_four_name'),
        comment: $r('app.string.first_four_comment')
      },
      {
        name: $r('app.string.first_five_name'),
        comment: $r('app.string.first_five_comment')
      }
    ]
  },
  {
    uri: $rawfile('video2.mp4'),
    name: $r('app.string.two_author'),
    peopleNum: '360',
    commentList: [
      {
        name: $r('app.string.first_one_name'),
        comment: $r('app.string.first_one_comment')
      },
      {
        name: $r('app.string.first_two_name'),
        comment: $r('app.string.first_two_comment')
      },
      {
        name: $r('app.string.first_three_name'),
        comment: $r('app.string.first_three_comment')
      },
      {
        name: $r('app.string.first_four_name'),
        comment: $r('app.string.first_four_comment')
      },
      {
        name: $r('app.string.first_five_name'),
        comment: $r('app.string.first_five_comment')
      }
    ]
  },
  { uri: $rawfile('video3.mp4'),
    name: $r('app.string.three_author'),
    peopleNum: '777',
    commentList: [
      {
        name: $r('app.string.first_one_name'),
        comment: $r('app.string.first_one_comment')
      },
      {
        name: $r('app.string.first_two_name'),
        comment: $r('app.string.first_two_comment')
      },
      {
        name: $r('app.string.first_three_name'),
        comment: $r('app.string.first_three_comment')
      },
      {
        name: $r('app.string.first_four_name'),
        comment: $r('app.string.first_four_comment')
      },
      {
        name: $r('app.string.first_five_name'),
        comment: $r('app.string.first_five_comment')
      }
    ]
  }
];